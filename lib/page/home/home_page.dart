import 'package:cached_network_image/cached_network_image.dart';
import 'package:eco_app/component/input/search_bar.dart';
import 'package:eco_app/component/not_found.dart';
import 'package:eco_app/component/shimer/shimer.dart';
import 'package:eco_app/data/reponsitory/product/models/list_product/data_product.dart';
import 'package:eco_app/data/data_local/user_bloc.dart';
import 'package:eco_app/database_local/product/models/count_model.dart';
import 'package:eco_app/helper/colors.dart';
import 'package:eco_app/helper/const.dart';
import 'package:eco_app/helper/context.dart';
import 'package:eco_app/helper/spaces.dart';
import 'package:eco_app/page/core/product_data.dart';
import 'package:eco_app/page/home/home_bloc.dart';
import 'package:eco_app/page/home/home_state.dart';
import 'package:eco_app/page/home/widgets/flash_deals.dart';
import 'package:eco_app/page/home/widgets/home_icon.dart';
import 'package:eco_app/page/product/detail/widgets/product_detail_params.dart';
import 'package:eco_app/qr/qr_page.dart';
import 'package:eco_app/resources/routes.dart';
import 'package:eco_app/theme/typography.dart';
import 'package:eco_app/utils/commons.dart';
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

  late HomeBloc bloc;
  final PagingController<int, DataProduct> _pagingController =
      PagingController(firstPageKey: startPage, invisibleItemsThreshold: 1);
  @override
  void initState() {
    bloc = HomeBloc()..getData();
    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey != startPage) {
        bloc.onFetch(page: pageKey);
      }
    });
    domain = context.read<UserBloc>().state.subDomain ?? '';
    super.initState();
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
  Widget _buildSearchField() {
    return AppSearchBar(
      hintText: 'Tìm kiếm  ',
      onChanged: (keyword) {
        setState(() {
          // keywordText = keyword;
        });
      },
    );
  }

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

  Widget _flashDealsProductGridView(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      slivers: [
        PagedSliverGrid(
          shrinkWrapFirstPageIndicators: true,
          pagingController: _pagingController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Số cột là 2
            mainAxisSpacing: 12.0,
            crossAxisSpacing: 6.0,
            childAspectRatio: 0.7.sp,
          ),
          builderDelegate: PagedChildBuilderDelegate<DataProduct>(
            itemBuilder: (context, item, index) =>
                _item(context, index: index, data: item),
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
          onTap: () {
            routeService.pushNamed(Routes.productDetailPage,
                arguments: ProductDetailParams(idProduct: data.id ?? ''));
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.h),
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
                          child: Image.network(
                            '$domain${data.image ?? ''}',
                            width: 75.w,
                            height: 75.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 16.h, left: 4.w, right: 4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '900.000 đ',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: colorMain,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              '1.200.000 đ',
                              style: textTheme.bodySmall?.copyWith(
                                color: colorItemCover,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
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
                        Text(
                          data.descriptions?[0].name ?? '',
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
                                    borderRadius: BorderRadius.circular(8.r),
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
                                  '1.3k/tháng',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  gradient: LinearGradient(
                                    stops: const [0.6, 0.02],
                                    colors: [
                                      colorMainCover,
                                      colorMainCover.withOpacity(0.4),
                                    ],
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4.w, vertical: 2.h),
                                child: Text(
                                  'Còn: 01 : 37: 00',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: colorWhite,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ),
                            spaceW4,
                            Text(
                              '60%',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: colorMain),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _item(BuildContext context,
      {required DataProduct data, required int index}) {
    return GestureDetector(
      onTap: () {
        routeService.pushNamed(Routes.productDetailPage,
            arguments: ProductDetailParams(idProduct: data.id ?? ''));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
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
                        imageUrl: '$domain${data.image ?? ''}',
                        width: 75.w,
                        height: 75.h,
                        fadeOutDuration: const Duration(seconds: 2),
                        placeholder: (context, url) => _shimerItem(context),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 16.h, left: 4.w, right: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '900.000 đ',
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: colorMain,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          '1.200.000 đ',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorItemCover,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
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
                    Text(
                      data.descriptions?[0].name ?? '',
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
                                borderRadius: BorderRadius.circular(8.r),
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
                              '1.3k/tháng',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              gradient: LinearGradient(
                                stops: const [0.6, 0.02],
                                colors: [
                                  colorMainCover,
                                  colorMainCover.withOpacity(0.4),
                                ],
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 2.h),
                            child: Text(
                              'Còn: 01 : 37: 00',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: colorWhite,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                        spaceW4,
                        Text(
                          '60%',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(color: colorMain),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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

Widget _shimerItem(BuildContext context) {
  return ShimmerEffect(
    child: Container(
      width: 75.w,
      height: 75.h,
      decoration: BoxDecoration(
        color: context.appColor.colorWhite,
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),
  );
}

Widget _shimmer(BuildContext context) {
  return Expanded(
    child: ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) => ShimmerEffect(
        child: Container(
          height: 100.h,
          decoration: BoxDecoration(
            color: context.appColor.colorWhite,
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
      separatorBuilder: (context, index) => spaceH12,
      itemCount: 4,
    ),
  );
}

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
        child: const Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            HomePageIcon(
              assetImageString: 'assets/images/user_information.png',
              itemString: "Tra cứu đơn hàng",
              destinationWidget: null,
              notifyNumber: "0",
            ),
            HomePageIcon(
              assetImageString: 'assets/images/recruitment.png',
              itemString: "Mua 1 tặng 1",
              destinationWidget: null,
              notifyNumber: "0",
            ),
            HomePageIcon(
              assetImageString: 'assets/images/maneuver.png',
              itemString: "Cẩm nang",
              destinationWidget: null,
              notifyNumber: "0",
            ),
            HomePageIcon(
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
