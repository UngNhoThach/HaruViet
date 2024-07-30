import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:haruviet/component/error/not_found.dart';
import 'package:haruviet/component/shimer/image_product_shimer.dart';
import 'package:haruviet/data/data_local/user_bloc.dart';
import 'package:haruviet/data/reponsitory/product/models/list_product/data_product/data_product.dart';
import 'package:haruviet/database_local/product/models/count_model.dart';
import 'package:haruviet/database_local/products_recommendation/id_product_recommendation_database.dart';
import 'package:haruviet/database_local/products_recommendation/models/id_products_recommendation_model.dart';
import 'package:haruviet/database_local/products_recommendation/models/products_recommendation_model.dart';
import 'package:haruviet/database_local/products_recommendation/products_recommendation_database.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/core/product_data.dart';
import 'package:haruviet/page/home/home_bloc.dart';
import 'package:haruviet/page/home/home_state.dart';
import 'package:haruviet/page/home/widgets/count_dount.dart';
import 'package:haruviet/page/home/widgets/flash_deals.dart';
import 'package:haruviet/page/home/widgets/home_icon.dart';
import 'package:haruviet/page/product/detail/widgets/product_detail_params.dart';
import 'package:haruviet/qr/qr_page.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // variables and functions
  late String domain;
  final IdProductRecommendationDatabase getIdProductRecommendation =
      IdProductRecommendationDatabase();
  late HomeBloc bloc;
  final PagingController<int, DataProduct> _pagingController =
      PagingController(firstPageKey: startPage, invisibleItemsThreshold: 3);
  @override
  void initState() {
    super.initState();
    bloc = HomeBloc()..getData();
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

  final _counterModel = CounterModel();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<HomeBloc, HomeState>(
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
          // BlocListener<HomeBloc, HomeState>(
          //   listenWhen: (previous, current) =>
          //       previous.productListLocal != current.productListLocal,
          //   listener: (context, state) {
          //     if (state.currentPage == startPage) {
          //       _pagingController.refresh();
          //     }
          //     if (state.canLoadMore) {
          //       _pagingController.appendPage(
          //         state.productListLocal ?? [],
          //         state.currentPage + 1,
          //       );
          //     } else {
          //       _pagingController.appendLastPage(state.newDataList ?? []);
          //     }
          //   },
          // ),
        ],
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Scaffold(
              body: RefreshIndicator(
                onRefresh: () async {
                  _pagingController.refresh();
                  bloc.onFetch(page: startPage);
                },
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Column(
                      children: [
                        //      Text('nhothach...${state.idProductListLocal[1].id}'),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  _recommendedProductListView(
                                      context, state, _counterModel),
                                  Column(
                                    children: [
                                      spaceH16,
                                      _homeIcon(context),
                                      spaceH20,
                                    ],
                                  ),
                                  _topCategoriesHeader(context,
                                      title: "Siêu ưu đãi", isTimer: true),
                                  spaceH4,
                                  _flashDealsProductListView(context),
                                  // sản phẩm mới xem
                                  state.productListLocal.isNotEmpty
                                      ? Column(
                                          children: [
                                            _topCategoriesHeader(context,
                                                title: "Sản phẩm mới xem",
                                                isTimer: false),
                                            spaceH4,
                                            _listdataLocal(context, state)
                                          ],
                                        )
                                      : space0,
                                  _topCategoriesHeader(context,
                                      title: "Sản phẩm mới", isTimer: false),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // spaceH16,
                        Row(
                          children: [
                            Expanded(
                                child: _flashDealsProductGridView(context)),
                          ],
                        ),
                        spaceH64,
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // widgets

  Widget _flashDealsProductListView(
    BuildContext context,
  ) {
    return SizedBox(
      height: 210.h,
      child: PagedListView.separated(
        scrollDirection: Axis.horizontal,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        pagingController: _pagingController,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        builderDelegate: PagedChildBuilderDelegate<DataProduct>(
          noItemsFoundIndicatorBuilder: _empty,
          itemBuilder: (context, item, index) {
            return _itemFlashSale(context, index: index, data: item);
          },
        ),
        separatorBuilder: (context, index) => spaceW12,
      ),
    );
  }

  Widget _listdataLocal(BuildContext context, HomeState state) {
    return SizedBox(
      height: 210.h, // Define a fixed height for the ListView
      child: ListView.separated(
        separatorBuilder: (context, index) => spaceW12,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: state.productListLocal.length,
        itemBuilder: (context, index) {
          return _itemDataLocal(context, data: state.productListLocal[index]);
        },
        physics: const BouncingScrollPhysics(),
      ),
    );
  }

  Widget _flashDealsProductGridView(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      slivers: [
        PagedSliverGrid(
          shrinkWrapFirstPageIndicators: true,
          pagingController: _pagingController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Số cột là 2
            mainAxisSpacing: 12.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 0.8,
          ),
          builderDelegate: PagedChildBuilderDelegate<DataProduct>(
            itemBuilder: (context, item, index) =>
                _itemFlashSale(context, index: index, data: item),
          ),
        ),
      ],
    );
  }

  Widget _itemDataLocal(
    BuildContext context, {
    required ProductRecommendationModel data,
  }) {
    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            // final ProductRecommendationDatabase test =
            //     ProductRecommendationDatabase();
            getIdProductRecommendation
                .insertProduct(IdProductRecommendationModel(id: data.id));
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Product inserted successfully')));
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
                                  data.promotionPrice?.pricePromotion?.price ==
                                          0
                                      ? '${data.price.price} \$'
                                      : '${data.promotionPrice?.pricePromotion?.price} \$',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        color: colorMain,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                data.promotionPrice?.pricePromotion?.price != 0
                                    ? Text(
                                        '${data.price.price} \$',
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
                            (data.descriptions.isEmpty)
                                ? Text(
                                    '',
                                    style: textTheme.labelMedium?.copyWith(
                                      color: colorBlackTileItem,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : Text(
                                    data.descriptions[0].name ?? '',
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
                            (data.promotionPrice?.dateEnd != null &&
                                    data.promotionPrice?.dateEnd != '')
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
              (data.promotionPrice?.dateEnd != null &&
                      data.promotionPrice?.dateEnd != '')
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
              (data.promotionPrice?.pricePromotion?.price != 0)
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
                          'Sale ${(((data.price.price ?? 0) - (data.promotionPrice?.pricePromotion?.price ?? 0)) / (data.price?.price ?? 0) * 100).floor()}%',
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

  Widget _itemFlashSale(BuildContext context,
      {required DataProduct data, required int index}) {
    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            // final ProductRecommendationDatabase test =
            //     ProductRecommendationDatabase();
            // waiting for check to complete

            // ProductRecommendationModel product =
            //     ProductRecommendationModel.fromDataProduct(data);
            // await test.insertProduct(product);
            getIdProductRecommendation
                .insertProduct(IdProductRecommendationModel(id: data.id ?? ''));
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Product inserted successfully')));
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
                              data.brand?.name ?? '',
                              style: textTheme.labelMedium?.copyWith(
                                color: colorSecondary04,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            spaceH4,
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    (data.descriptions == null ||
                                            data.descriptions!.isEmpty)
                                        ? ''
                                        : data.descriptions![0].name ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.labelMedium?.copyWith(
                                      color: colorBlackTileItem,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
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

                                      // Expanded(
                                      //   child: Container(
                                      //       decoration: BoxDecoration(
                                      //         borderRadius:
                                      //             BorderRadius.circular(8.r),
                                      //         gradient: LinearGradient(
                                      //           stops: const [0.6, 0.02],
                                      //           colors: [
                                      //             colorMainCover,
                                      //             colorMainCover
                                      //                 .withOpacity(0.4),
                                      //           ],
                                      //         ),
                                      //       ),
                                      //       //
                                      //       padding: EdgeInsets.symmetric(
                                      //           horizontal: 4.w, vertical: 2.h),
                                      //       child: CountdownTimer(
                                      //           dateStart: data.promotionPrice
                                      //                   ?.dateStart ??
                                      //               '',
                                      //           dateEnd: data.promotionPrice
                                      //                   ?.dateEnd ??
                                      //               '')

                                      //       //  Text(

                                      //       //   '${data.promotionPrice?.dateStart ?? ''}'
                                      //       //   'Còn: 01 : 37: 00',
                                      //       //   style: Theme.of(context)
                                      //       //       .textTheme
                                      //       //       .labelSmall
                                      //       //       ?.copyWith(
                                      //       //         color: colorWhite,
                                      //       //         fontWeight: FontWeight.w500,
                                      //       //       ),
                                      //       // ),
                                      //       ),
                                      // ),
                                      spaceW4,
                                      // Text(
                                      //   '60%',
                                      //   style: Theme.of(context)
                                      //       .textTheme
                                      //       .labelMedium
                                      //       ?.copyWith(color: colorMain),
                                      // ),
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
}

Widget _recommendedProductListView(
    BuildContext context, HomeState state, _counterModel) {
  return SizedBox(
    height: 180.h,
    child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: AppData.recommendedProducts.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Container(
              width: 300.w,
              decoration: BoxDecoration(
                color: AppData.recommendedProducts[index].cardBackgroundColor,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Giảm giá 30%  \nCOVID 19',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.white),
                        ),
                        spaceH8,
                        ElevatedButton(
                          onPressed: () {
                            _counterModel.increment();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppData.recommendedProducts[index]
                                .buttonBackgroundColor,
                            elevation: 0,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                          child: Text(
                            "Xem ngay",
                            style: TextStyle(
                              color: AppData
                                  .recommendedProducts[index].buttonTextColor!,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    'assets/images/shopping.png',
                    height: 125.h,
                    fit: BoxFit.cover,
                  )
                ],
              ),
            ),
          );
        }),
  );
}

Widget _empty(BuildContext context) {
  return const DidntFound();
}

// Widget _shimmer(BuildContext context) {
//   return Expanded(
//     child: ListView.separated(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       padding: const EdgeInsets.all(16),
//       itemBuilder: (context, index) => ShimmerEffect(
//         child: Container(
//           height: 100.h,
//           decoration: BoxDecoration(
//             color: context.appColor.colorWhite,
//             borderRadius: BorderRadius.circular(16.0),
//           ),
//         ),
//       ),
//       separatorBuilder: (context, index) => spaceH12,
//       itemCount: 4,
//     ),
//   );
// }

Widget _topCategoriesHeader(
  BuildContext context, {
  required final String title,
  required bool isTimer,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        isTimer ? const FlashDealsTimer() : const SizedBox(),
        TextButton(
          onPressed: () {
            routeService.pushNamed(Routes.productListPage);
          },
          child: Text(
            "Xem tất cả",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.deepOrange.withOpacity(0.7)),
          ),
        )
      ],
    ),
  );
}

Widget _homeIcon(BuildContext context) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        width: MediaQuery.of(context).size.width,
        height: 80,
        child: const Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            HomePageIcon(
              assetImageString: 'assets/images/qr_png.png',
              itemString: "Mã QR của tôi",
              destinationWidget: QrCodePage(),
              notifyNumber: "0",
            ),
            HomePageIcon(
              assetImageString: 'assets/images/recruitment.png',
              itemString: "Hàng mới về",
              destinationWidget: QrCodePage(),
              notifyNumber: "0",
            ),
            HomePageIcon(
              assetImageString: 'assets/images/maneuver.png',
              itemString: "Giao 2h",
              destinationWidget: null,
              notifyNumber: "0",
            ),
            HomePageIcon(
              assetImageString: 'assets/images/education.png',
              itemString: "Bảng giá",
              destinationWidget: null,
              notifyNumber: "0",
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 32,
      ),
      Container(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        width: MediaQuery.of(context).size.width,
        height: 80,
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            HomePageIcon(
              assetImageString: 'assets/images/user_information.png',
              itemString: "Tra cứu đơn hàng",
              onTap: () {
                routeService.pushNamed(
                  Routes.ordersPage,
                );
              },
              destinationWidget: null, // OrdersPage(),
              notifyNumber: "0",
            ),
            const HomePageIcon(
              assetImageString: 'assets/images/recruitment.png',
              itemString: "Mua 1 tặng 1",
              destinationWidget: null,
              notifyNumber: "0",
            ),
            const HomePageIcon(
              assetImageString: 'assets/images/maneuver.png',
              itemString: "Cẩm nang",
              destinationWidget: null,
              notifyNumber: "0",
            ),
            const HomePageIcon(
              assetImageString: 'assets/images/education.png',
              itemString: "Thông báo",
              destinationWidget: null,
              notifyNumber: "0",
            ),
          ],
        ),
      ),
    ],
  );
}
