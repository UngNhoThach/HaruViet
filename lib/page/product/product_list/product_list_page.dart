import 'package:eco_app/component/header/header_item.dart';
import 'package:eco_app/component/input/search_bar.dart';
import 'package:eco_app/component/not_found.dart';
import 'package:eco_app/component/shimer/shimer.dart';
import 'package:eco_app/data/reponsitory/product/models/list_product/data_product.dart';
import 'package:eco_app/data/data_local/user_bloc.dart';
import 'package:eco_app/helper/colors.dart';
import 'package:eco_app/helper/const.dart';
import 'package:eco_app/helper/context.dart';
import 'package:eco_app/helper/spaces.dart';
import 'package:eco_app/page/cart/models/cart_page_params.dart';
import 'package:eco_app/page/product/detail/product_deatail_page.dart';
import 'package:eco_app/page/product/detail/widgets/product_detail_params.dart';
import 'package:eco_app/page/product/product_list/product_list_bloc.dart';
import 'package:eco_app/page/product/product_list/product_list_state.dart';
import 'package:eco_app/resources/routes.dart';
import 'package:eco_app/theme/typography.dart';
import 'package:eco_app/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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

    super.initState();
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
                    checkIsChangeListItem
                        ? state.newDataList == null
                            ? _shimmer(context)
                            : Expanded(
                                child: Padding(
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
                                          crossAxisSpacing: 6.0,
                                          childAspectRatio: 0.7,
                                        ),
                                        builderDelegate:
                                            PagedChildBuilderDelegate<
                                                DataProduct>(
                                          itemBuilder: (context, item, index) =>
                                              _itemGridView(context,
                                                  index: index, data: item),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                        : state.newDataList == null
                            ? _shimmer(context)
                            : Expanded(
                                child: PagedListView.separated(
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
        itemCount: 10,
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
                child: Image.network(
                  width: 100,
                  height: 90,
                  '$domain${data.image}',
                  // 'https://bizweb.dktcdn.net/thumb/large/100/465/278/products/samsung-inverter-488-lit-rf48a4010b4-sv-2-1-1667208459141.jpg?v=1700295265767',
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
                          '900.000 đ',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: colorMain,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          '1.200.000 đ',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: colorItemCover,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                        ),
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
                    Text(
                      data.descriptions?[0].name ?? '',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
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
                                    fontWeight: FontWeight.bold,
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
    return GestureDetector(
      onTap: () {
        routeService.pushNamed(Routes.productDetailPage);
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

  // Widget _flashDealsProductGridView(BuildContext context,
  //     {required DataProduct data, required int index}) {
  //   return Card(
  //     semanticContainer: true,
  //     elevation: 3,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(8.r),
  //     ),
  //     child: InkWell(
  //       onTap: () {
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (builder) => const ProductDetailPage()));
  //         //ProductDetailPage
  //       },
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           ClipRRect(
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(8.r),
  //               topRight: Radius.circular(8.r),
  //             ),
  //             child: Image.network(
  //               width: 100.w,
  //               height: 100.h,
  //               '$domain${data.image}',
  //             ),
  //           ),
  //           spaceH20,
  //           Expanded(
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 spaceH6,
  //                 Row(
  //                   children: [
  //                     Text(
  //                       '900.000 đ',
  //                       style: Theme.of(context).textTheme.subtitle1?.copyWith(
  //                             color: colorMain,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                     ),
  //                     Text(
  //                       '1.200.000 đ',
  //                       style: Theme.of(context).textTheme.subtitle2?.copyWith(
  //                             color: colorItemCover,
  //                             decoration: TextDecoration.lineThrough,
  //                           ),
  //                     ),
  //                   ],
  //                 ),
  //                 spaceH4,
  //                 Text(
  //                   'Thương hiệu: Samsung',
  //                   style: textTheme.caption?.copyWith(
  //                     color: colorSecondary04,
  //                     fontWeight: FontWeight.w500,
  //                   ),
  //                 ),
  //                 Row(
  //                   children: [
  //                     Flexible(
  //                       child: Text(
  //                         maxLines: null,
  //                         'Tủ lạnh Samsung Inverter 599 lít',
  //                         style: Theme.of(context).textTheme.caption?.copyWith(
  //                               color: colorBlackTileItem,
  //                               fontWeight: FontWeight.w500,
  //                             ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 spaceH6,
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Row(
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       children: [
  //                         Container(
  //                           width: 42.w,
  //                           decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(8.r),
  //                             color: colorMainCover,
  //                           ),
  //                           padding: EdgeInsets.symmetric(
  //                               horizontal: 4.w, vertical: 2.h),
  //                           child: Row(
  //                             children: [
  //                               Text(
  //                                 '4.8',
  //                                 style: Theme.of(context)
  //                                     .textTheme
  //                                     .labelSmall
  //                                     ?.copyWith(
  //                                       color: colorBackgroundWhite,
  //                                       fontWeight: FontWeight.bold,
  //                                     ),
  //                               ),
  //                               spaceW2,
  //                               Icon(
  //                                 Icons.star,
  //                                 size: 12.sp,
  //                                 color: colorBackgroundWhite,
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                         spaceW2,
  //                         Text(
  //                           '(120)',
  //                           style: Theme.of(context)
  //                               .textTheme
  //                               .labelSmall
  //                               ?.copyWith(
  //                                 color: colorBlueGray02,
  //                                 fontWeight: FontWeight.w500,
  //                               ),
  //                         ),
  //                       ],
  //                     ),
  //                     Row(
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       children: [
  //                         Icon(
  //                           Icons.shopping_cart_outlined,
  //                           color: colorBlueGray02,
  //                           size: 12.sp,
  //                         ),
  //                         spaceW2,
  //                         Text(
  //                           '1.3k/tháng',
  //                           style: Theme.of(context)
  //                               .textTheme
  //                               .labelSmall
  //                               ?.copyWith(
  //                                 color: colorBlueGray02,
  //                                 fontWeight: FontWeight.w500,
  //                               ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //                 spaceH6,
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Expanded(
  //                       child: Container(
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(8),
  //                           gradient: LinearGradient(
  //                             stops: const [0.6, 0.02],
  //                             colors: [
  //                               colorMainCover,
  //                               colorMainCover.withOpacity(0.4),
  //                             ],
  //                           ),
  //                         ),
  //                         padding: const EdgeInsets.symmetric(
  //                             horizontal: 4, vertical: 2),
  //                         child: Text(
  //                           'Còn: 01 : 37: 00',
  //                           style: Theme.of(context)
  //                               .textTheme
  //                               .labelSmall
  //                               ?.copyWith(
  //                                 color: colorWhite,
  //                                 fontWeight: FontWeight.bold,
  //                               ),
  //                         ),
  //                       ),
  //                     ),
  //                     spaceW4,
  //                     Text(
  //                       '60%',
  //                       style: Theme.of(context)
  //                           .textTheme
  //                           .labelMedium
  //                           ?.copyWith(color: colorMain),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

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
