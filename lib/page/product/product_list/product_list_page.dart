import 'package:cached_network_image/cached_network_image.dart';
import 'package:haruviet/component/header/header_item.dart';
import 'package:haruviet/component/input/search_bar.dart';
import 'package:haruviet/component/error/not_found.dart';
import 'package:haruviet/component/shimer/image_product_shimer.dart';
import 'package:haruviet/component/shimer/shimer.dart';
import 'package:haruviet/data/data_local/user_bloc.dart';
import 'package:haruviet/data/reponsitory/product/models/list_product/data_product/data_product.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/cart/models/cart_page_params.dart';
import 'package:haruviet/page/home/widgets/count_dount.dart';
import 'package:haruviet/page/product/detail/product_deatail_page.dart';
import 'package:haruviet/page/product/detail/widgets/product_detail_params.dart';
import 'package:haruviet/page/product/product_list/product_list_bloc.dart';
import 'package:haruviet/page/product/product_list/product_list_state.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shimmer/shimmer.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  // variables and functions
  final PagingController<int, DataProduct> _pagingController =
      PagingController(firstPageKey: startPage, invisibleItemsThreshold: 3);
  bool checkIsChangeListItem = false;
  late String domain;

  late ProductListBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = ProductListBloc()..getData();
    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey != startPage) {
        bloc.onFetch(page: pageKey);
      }
    });
    domain = context.read<UserBloc>().state.subDomain ?? '';
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<ProductListBloc, ProductListState>(
            listenWhen: (previous, current) =>
                previous.newDataList != current.newDataList,
            listener: (context, state) {
              if (state.currentPage == startPage) {
                _pagingController.refresh();
              }
              if (state.canLoadMore) {
                _pagingController.appendPage(
                  state.newDataList ?? [],
                  state.currentPage + 1,
                );
              } else {
                _pagingController.appendLastPage(state.newDataList ?? []);
              }
            },
          ),
        ],
        child: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: _buildSearchField(),
                backgroundColor: colorMain,
                actions: <Widget>[
                  IconButton(
                    onPressed: () {
                      routeService.pushNamed(Routes.cartPage,
                          arguments: CartPageParams(isAppBar: true));
                    },
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      color: colorWhite,
                      weight: 2.5,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        checkIsChangeListItem = !checkIsChangeListItem;
                      });
                    },
                    icon: Icon(
                      checkIsChangeListItem
                          ? Icons.border_all
                          : Icons.format_line_spacing_outlined,
                      color: colorWhite,
                      weight: 2.5,
                    ),
                  ),
                ],
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  _pagingController.refresh();
                  bloc.onFetch(page: startPage);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FilterProductList(
                      statusSelected: 2,
                      onSelect: () {},
                    ),
                    // state.newDataList == null
                    //     ? _shimmer(context)
                    //     :
                    Expanded(
                      child: checkIsChangeListItem
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: CustomScrollView(
                                slivers: [
                                  PagedSliverGrid(
                                    shrinkWrapFirstPageIndicators: true,
                                    pagingController: _pagingController,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, // Số cột là 2
                                      mainAxisSpacing: 12.0,
                                      crossAxisSpacing: 8.0,
                                      childAspectRatio: 0.8,
                                    ),
                                    builderDelegate:
                                        PagedChildBuilderDelegate<DataProduct>(
                                      itemBuilder: (context, item, index) =>
                                          _itemGridView(context,
                                              index: index, data: item),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : PagedListView.separated(
                              scrollDirection: Axis.vertical,
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              pagingController: _pagingController,
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              builderDelegate:
                                  PagedChildBuilderDelegate<DataProduct>(
                                noItemsFoundIndicatorBuilder: _empty,
                                itemBuilder: (context, item, index) {
                                  return _item(context,
                                      index: index, data: item);
                                },
                              ),
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                color: colorBlueGray03,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _item(BuildContext context,
      {required DataProduct data, required int index}) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => ProductDetailPage(
                      params: ProductDetailParams(idProduct: data.id ?? ''),
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: CachedNetworkImage(
                  fadeOutDuration: const Duration(seconds: 3),
                  //  const Duration(seconds: 3),
                  imageUrl: '$domain${data.image}',
                  width: 100,
                  height: 90,
                  placeholder: (context, url) => const ImageProductShimer(
                      height: 90,
                      width: 100), // Use the custom shimmer component

                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                padding: EdgeInsets.only(top: 16.h, left: 4.w, right: 4.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data.promotionPrice == null
                              ? '${data.price?.price} \$'
                              : '${data.promotionPrice?.pricePromotion?.price} \$',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: colorMain,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        data.promotionPrice != null
                            ? Text(
                                '${data.price?.price} \$',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: colorItemCover,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                              )
                            : space0,
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Thương hiệu: Samsung',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: colorSecondary04,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(height: 4),
                    (data.descriptions == null || data.descriptions!.isEmpty)
                        ? space0
                        : Text(
                            data.descriptions![0].name ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: colorBlackTileItem,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 42.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: colorMainCover,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              child: Row(
                                children: [
                                  Text(
                                    '4.8',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: colorBackgroundWhite,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  spaceW2,
                                  Icon(
                                    Icons.star,
                                    size: 12.sp,
                                    color: colorBackgroundWhite,
                                  ),
                                ],
                              ),
                            ),
                            spaceW2,
                            Text(
                              '(120)',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: colorBlueGray02,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: colorBlueGray02,
                              size: 12.sp,
                            ),
                            spaceW2,
                            Text(
                              '${data.sold} mua',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: colorBlueGray02,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    spaceH6,
                    data.promotionPrice?.dateEnd != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: colorMainCover),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4.w, vertical: 2.h),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.w),
                                    child: CountdownTimer(
                                        dateStart:
                                            data.promotionPrice?.dateStart ??
                                                '',
                                        dateEnd:
                                            data.promotionPrice?.dateEnd ?? ''),
                                  ),
                                ),
                              ),
                              spaceW4,
                            ],
                          )
                        : space0,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _empty(BuildContext context) {
    return const DidntFound();
  }

  Widget _itemGridView(BuildContext context,
      {required DataProduct data, required int index}) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            routeService.pushNamed(Routes.productDetailPage,
                arguments: ProductDetailParams(idProduct: data.id ?? ''));
          },
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: colorWhite,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x3600000F),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.46,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0.r),
                                bottomRight: Radius.circular(0.r),
                                topLeft: Radius.circular(8.r),
                                topRight: Radius.circular(8.r),
                              ),
                              child: CachedNetworkImage(
                                fadeOutDuration: const Duration(seconds: 3),
                                //  const Duration(seconds: 3),
                                imageUrl: '$domain${data.image}',
                                width: 72.w,
                                height: 72.h,
                                placeholder: (context, url) =>
                                    ImageProductShimer(
                                  width: 72.w,
                                  height: 72.h,
                                ), // Use the custom shimmer component
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding:
                            const EdgeInsets.only(top: 16, left: 4, right: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data.promotionPrice == null
                                      ? '${data.price?.price} \$'
                                      : '${data.promotionPrice?.pricePromotion?.price} \$',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        color: colorMain,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                data.promotionPrice != null
                                    ? Text(
                                        '${data.price?.price} \$',
                                        style: textTheme.bodySmall?.copyWith(
                                          color: colorItemCover,
                                          fontWeight: FontWeight.bold,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      )
                                    : space0,
                              ],
                            ),
                            spaceH4,
                            Text(
                              'Thương hiệu: Samsung',
                              style: textTheme.labelMedium?.copyWith(
                                color: colorSecondary04,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            spaceH4,
                            (data.descriptions == null ||
                                    data.descriptions!.isEmpty)
                                ? space0
                                : Text(
                                    data.descriptions![0].name ?? '',
                                    style: textTheme.labelMedium?.copyWith(
                                      color: colorBlackTileItem,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                            spaceH4,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 42.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: colorMainCover,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4.w, vertical: 2.h),
                                      child: Row(
                                        children: [
                                          Text(
                                            '4.8',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall
                                                ?.copyWith(
                                                  color: colorBackgroundWhite,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                          spaceW2,
                                          Icon(
                                            Icons.star,
                                            size: 12.sp,
                                            color: colorBackgroundWhite,
                                          ),
                                        ],
                                      ),
                                    ),
                                    spaceW2,
                                    Text(
                                      '(120)',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            color: colorBlueGray02,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.shopping_cart_outlined,
                                      color: colorBlueGray02,
                                      size: 12.sp,
                                    ),
                                    spaceW2,
                                    Text(
                                      '${data.sold} mua',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            color: colorBlueGray02,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            spaceH6,
                            data.promotionPrice?.dateEnd != null
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                color: colorMainCover),
                                            //
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4.w, vertical: 2),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: CountdownTimer(
                                                  dateStart: data.promotionPrice
                                                          ?.dateStart ??
                                                      '',
                                                  dateEnd: data.promotionPrice
                                                          ?.dateEnd ??
                                                      ''),
                                            )),
                                      ),
                                      spaceW4,
                                    ],
                                  )
                                : const SizedBox(
                                    height: 16,
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              data.promotionPrice?.dateEnd != null
                  ? Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.r),
                            bottomRight: Radius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          'Flash Sale',
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    )
                  : space0,
              data.promotionPrice?.pricePromotion?.price != null
                  ? Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8.r),
                            bottomLeft: Radius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          'Sale ${(((data.price?.price ?? 0) - (data.promotionPrice?.pricePromotion?.price ?? 0)) / (data.price?.price ?? 0) * 100).floor()}%',
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: colorBlack,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    )
                  : space0,
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return AppSearchBar(
      hintText: 'Tìm kiếm sản phẩm',
      onChanged: (keyword) {
        setState(() {
          // keywordText = keyword;
          // _onTapWorkPlan = !_onTapWorkPlan;
        });
      },
    );
  }
}
