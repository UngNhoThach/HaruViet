import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:haruviet/component/error/not_found.dart';
import 'package:haruviet/component/error/not_found_item.dart';
import 'package:haruviet/component/loading/loading.dart';
import 'package:haruviet/component/loading_scaffold.dart';
import 'package:haruviet/connection.dart';
import 'package:haruviet/connection/widgets/connection_widget.dart';
import 'package:haruviet/data/data_local/setting_app_bloc.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/database_local/product/models/count_model.dart';
import 'package:haruviet/database_local/products_recommendation/id_product_recommendation_database.dart';
import 'package:haruviet/firebase_api.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/core/product_data.dart';
import 'package:haruviet/page/home/home_bloc.dart';
import 'package:haruviet/page/home/home_state.dart';
import 'package:haruviet/page/product/widgets/header_top_widget.dart';
import 'package:haruviet/page/home/widgets/card_widget.dart';
import 'package:haruviet/page/home/widgets/scroll_to_top_widget.dart';
import 'package:haruviet/page/product/widgets/item_products_widget.dart';
import 'package:haruviet/page/product/widgets/widget_products_one_row_loading.dart';
import 'package:haruviet/qr/qr_page.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'widgets/brand_widget.dart';
import 'widgets/home_icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // variables and functions

  late String domain;
  final IdProductRecommendationDatabase getIdProductRecommendation =
      IdProductRecommendationDatabase();
  late HomeBloc bloc;
  late double childAspectRatio;
  double _previousScrollPosition = 0;
  late double _scrollThreshold; // Ngưỡng cuộn 200px
  bool isQR = false;
  final PagingController<int, DataProduct> _pagingController =
      PagingController(firstPageKey: startPage, invisibleItemsThreshold: 3);
  final PagingController<int, DataProduct> _pagingControllerFlashDeals =
      PagingController(firstPageKey: startPage, invisibleItemsThreshold: 3);
  final ScrollController _scrollController = ScrollController();

  FocusNode focusNode = FocusNode();
  final ItemProductWidget itemProductWidgets = ItemProductWidget();

  // check connection
  late StreamSubscription connectionChangeStream;
  bool isOffline = false;
  @override
  void initState() {
    super.initState();

    // build widget first
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenHeight = MediaQuery.of(context).size.height;
      // allow notifications
      FireBaseApi().settingNotification();
      setState(() {
        _scrollThreshold =
            screenHeight; // Gán chiều cao màn hình vào _scrollThreshold
      });
    });
// check connection change
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);
    if (!connectionStatus.hasConnection) {
      isOffline = !connectionStatus.hasConnection;
    } else {}

    bloc = HomeBloc()..getData();
    // _pagingControllerFlashDeals
    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey != startPage) {
        bloc.onFetch(page: pageKey);
      }
    });

    _pagingControllerFlashDeals.addPageRequestListener((pageKey) {
      if (pageKey != startPage) {
        bloc.onGetProductsFlashsale(page: pageKey);
      }
    });
    // handle scroll
    _onScroll();
    domain = context.read<SettingAppBloc>().state.xUrl ?? '';
  }

  void _onScroll() {
    _scrollController.addListener(() {
      if (bloc.canLoadMore &&
          _scrollController.position.pixels - _previousScrollPosition >=
              _scrollThreshold * 2) {
        bool isFetchingData = false;
        if (!isFetchingData) {
          final nextPageKey = _pagingController.nextPageKey;
          if (nextPageKey != startPage) {
            isFetchingData = true; // Set the flag to true
            _pagingController.notifyPageRequestListeners(nextPageKey!);
            // Listen to the bloc's state to reset the fetching flag
            bloc.stream.listen((state) {
              if (!state.isLoading) {
                isFetchingData =
                    false; // Reset the flag when loading is complete
              }
            });
            //}
          }
        }
        // Người dùng đã cuộn ít nhất 200px kể từ lần tải trước
        _previousScrollPosition = _scrollController
            .position.pixels; // Cập nhật lại vị trí cuộn trước đó
      }
    });
  }

  connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
    });
  }

  @override
  void dispose() {
    _pagingControllerFlashDeals.dispose();
    _pagingController.dispose();
    _scrollController.dispose();
    _counterModel.dispose();
    super.dispose();
  }

  final _counterModel = CounterModel();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      key: ObjectKey(isOffline),
      providers: [
        BlocProvider(
          create: (context) => bloc,
        ),
      ],
      child: Scaffold(
        floatingActionButton: ScrollToTopButton(
          showOffset: 200,
          scrollController: _scrollController,
          backgroundColor: colorGray04.withOpacity(0.3),
          iconColor: colorWhite,
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        body: isOffline
            ? ConnectionWidget(
                onPressed: () {
                  bloc.getData();
                },
              )
            : MultiBlocListener(
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
                        _pagingController
                            .appendLastPage(state.newDataList ?? []);
                      }
                    },
                  ),
                  BlocListener<HomeBloc, HomeState>(
                    listenWhen: (previous, current) =>
                        previous.newDataListProductFlashDeal !=
                        current.newDataListProductFlashDeal,
                    listener: (context, state) {
                      if (state.currentPageProductFlashDeal == startPage) {
                        _pagingControllerFlashDeals.refresh();
                      }
                      // get data products flash deals
                      if (state.canLoadMoreProductFlashDeal) {
                        _pagingControllerFlashDeals.appendPage(
                          state.newDataListProductFlashDeal,
                          state.currentPageProductFlashDeal + 1,
                        );
                      } else {
                        _pagingControllerFlashDeals
                            .appendLastPage(state.newDataListProductFlashDeal);
                      }
                    },
                  ),

                  //
                  //  isOffline
                ],
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    return (state.isLoadingBrands &&
                            state.isLoading &&
                            !state.isPendingLoading)
                        ? const LoadingLogo()
                        : LoadingScaffold(
                            isLoading: state.isPendingLoading,
                            child: Builder(builder: (context) {
                              return RefreshIndicator(
                                  onRefresh: () async {
                                    _pagingController.refresh();
                                    _pagingControllerFlashDeals.refresh();
                                    _previousScrollPosition = 0;
                                    bloc.onReset();
                                  },
                                  child: _body(context, state: state));
                            }),
                          );
                  },
                ),
              ),
      ),
    );
  }

  // widgets

  Widget _itemGridView(
    BuildContext context, {
    required DataProduct data,
    required int index,
    required String domain,
  }) {
    return itemProductWidgets.itemGridView(
      context,
      data: data,
      index: index,
      domain: domain,
    );
  }

  Widget _flashDealsWidget() {
    return WidgetProductOneRowLoading(
      height: 280,
      gradientColor: colorMainCover,
      pagingController: _pagingControllerFlashDeals,
      itemBuilder: (context, item, index) {
        return itemProductWidgets.itemGridView(
          height: 260,
          context,
          data: item,
          index: index,
          domain: domain,
        );
      },
      noItemsFoundIndicatorBuilder: bloc.state.isPendingLoading ? _empty : null,
    );
  }

  Widget _body(BuildContext context, {required HomeState state}) {
    childAspectRatio = MediaQuery.of(context).size.width /
        (MediaQuery.of(context).size.height / 1.3.h);

    return CustomScrollView(
      controller: _scrollController, // Sử dụng chung ScrollController
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              color: colorBlueGray01,
              child: _recommendedProductListView(context, state, _counterModel),
            ),
            Container(
              color: colorBlueGray01,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
              child: _homeIcon(context, bloc: bloc),
            ),

            // start top brands
            state.listTopBrands == null || state.listTopBrands!.isEmpty
                ? space0
                : Column(
                    children: [
                      TopCategoriesHeader(
                          onPressed: () {
                            routeService.pushNamed(
                              Routes.brandsListPage,
                            );
                          },
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          backgroundColor: colorMainCover,
                          colorText: colorWhite,
                          isBorder: true,
                          title: "Thương hiệu",
                          isTimer: false),
                      Container(
                        padding:
                            const EdgeInsets.only(right: 16, left: 16, top: 20),
                        color: colorBlueGray01,
                        child: Column(
                          children: List.generate(
                            (state.listTopBrands!.length / 4).ceil(),
                            (rowIndex) {
                              final rowItems = state.listTopBrands!
                                  .skip(rowIndex * 4)
                                  .take(4)
                                  .toList();
                              return Padding(
                                padding: EdgeInsets.only(bottom: 24.h),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 80,
                                  child: Wrap(
                                    alignment: WrapAlignment.spaceBetween,
                                    children: List.generate(
                                      rowItems.length,
                                      (index) {
                                        final item = rowItems[index];
                                        return BrandWidget(
                                          onTap: () {
                                            bloc.onChangeViewMember();
                                          },
                                          assetImageString:
                                              '$domain${item?.image ?? ''}',
                                          itemString: item?.name ?? '',
                                          destinationWidget: null,
                                          notifyNumber: "0",
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

            // end top brands

            Column(
              children: [
                const TopCategoriesHeader(
                    colorText: colorWhite,
                    backgroundColor: colorMainCover,
                    isBorder: true,
                    title: "Siêu ưu đãi",
                    isTimer: false),
                // widget products flash deal
                _flashDealsWidget(),
              ],
            ),
            const TopCategoriesHeader(
                isBorder: true, title: "Sản phẩm mới", isTimer: false),
            spaceH10,
          ]),
        ),
        _buildPagedSliverGrid(),
      ],
    );
  }

  Widget _buildPagedSliverGrid() {
    return SliverToBoxAdapter(
      child: MasonryGridView.count(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        itemCount: _pagingController.itemList?.length ?? 0,
        itemBuilder: (context, index) {
          final item = _pagingController.itemList?[index];
          return _itemGridView(
            context,
            index: index,
            data: item!,
            domain: domain,
          );
        },
      ),
    );
  }
}

Widget _recommendedProductListView(
    BuildContext context, HomeState state, _counterModel) {
  return SizedBox(
    height: 200,
    child: ListView.builder(
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

Widget _homeIcon(BuildContext context, {required HomeBloc bloc}) {
  return AnimatedSwitcher(
    duration: const Duration(milliseconds: 400),
    transitionBuilder: (Widget child, Animation<double> animation) {
      return FadeTransition(opacity: animation, child: child);
    },
    child: bloc.state.isViewMemberCard
        ? Column(
            key: ValueKey(1),
            children: [
              GestureDetector(
                onTap: () => bloc.onChangeViewMember(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Đóng',
                      style:
                          textTheme.bodyLarge?.copyWith(color: colorMainCover),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              CreditCardsPage(),
            ],
          )
        : Column(
            key: ValueKey(2),
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 80,
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    HomePageIcon(
                      onTap: () {
                        bloc.onChangeViewMember();
                      },
                      assetImageString: 'assets/images/qr_png.png',
                      itemString: "Xem đối tác",
                      destinationWidget: const QrCodePage(),
                      notifyNumber: "0",
                    ),
                    const HomePageIcon(
                      assetImageString: 'assets/images/recruitment.png',
                      itemString: "Hàng mới về",
                      destinationWidget: null,
                      //       destinationWidget: QrCodePage(),
                      notifyNumber: "0",
                    ),
                    const HomePageIcon(
                      assetImageString: 'assets/images/maneuver.png',
                      itemString: "Giao 2h",
                      destinationWidget: null,
                      notifyNumber: "0",
                    ),
                    const HomePageIcon(
                      assetImageString: 'assets/images/education.png',
                      itemString: "Bảng giá",
                      destinationWidget: null,
                      notifyNumber: "0",
                    ),
                  ],
                ),
              ),
            ],
          ),
  );
}

class AnimatedProductGridItem extends StatelessWidget {
  final Widget child;
  final int index;

  const AnimatedProductGridItem({
    Key? key,
    required this.child,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.6, end: 1.0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
