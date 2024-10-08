import 'package:haruviet/component/error/not_found.dart';
import 'package:haruviet/data/data_local/user_bloc.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/database_local/product/models/count_model.dart';
import 'package:haruviet/database_local/products_recommendation/id_product_recommendation_database.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/core/product_data.dart';
import 'package:haruviet/page/home/home_bloc.dart';
import 'package:haruviet/page/home/home_state.dart';
import 'package:haruviet/page/home/widgets/flash_deals.dart';
import 'package:haruviet/page/home/widgets/home_icon.dart';
import 'package:haruviet/page/product/product_list/widgets/product_list_page_params.dart';
import 'package:haruviet/page/product/widgets/item_products_widget.dart';
import 'package:haruviet/qr/qr_page.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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

  final PagingController<int, DataProduct> _pagingController =
      PagingController(firstPageKey: startPage, invisibleItemsThreshold: 3);

  FocusNode focusNode = FocusNode();
  final ItemProductWidget itemProductWidgets = ItemProductWidget();

  @override
  void initState() {
    super.initState();

    bloc = HomeBloc()..getData();

    // data main
    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey != startPage) {
        bloc.onFetch(page: pageKey);
      }
    });
    // data sales

    domain = context.read<UserBloc>().state.subDomain ?? '';
    // _scrollController = ScrollController();
    // _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _counterModel.dispose();
    super.dispose();
  }

  final _counterModel = CounterModel();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => bloc,
        ),
      ],
      child: Scaffold(
        body: MultiBlocListener(
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
              return RefreshIndicator(
                  onRefresh: () async {
                    _pagingController.refresh();
                    bloc.onFetch(page: startPage);
                  },
                  child: _body(context, state: state));
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
    return itemProductWidgets.itemGridView(context,
        data: data, index: index, domain: domain);
  }

  Widget _flashDealsProduct() {
    return SizedBox(
      height: 230,
      child: PagedListView.separated(
        scrollDirection: Axis.horizontal,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        pagingController: _pagingController,
        physics: const ClampingScrollPhysics(),
        builderDelegate: PagedChildBuilderDelegate<DataProduct>(
          noItemsFoundIndicatorBuilder: _empty,
          itemBuilder: (context, item, index) {
            return itemProductWidgets.itemGridView(context,
                data: item, index: index, domain: domain);
          },
        ),
        separatorBuilder: (context, index) => spaceW12,
      ),
    );
  }

  Widget _body(BuildContext context, {required HomeState state}) {
    childAspectRatio = MediaQuery.of(context).size.width /
        (MediaQuery.of(context).size.height / 1.35.h);

    return CustomScrollView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      slivers: [
        _buildSliverAppBar(state),
        _buildHeader(),
        _buildPagedSliverGrid(),
      ],
    );
  }

  Widget _buildSliverAppBar(HomeState state) {
    return SliverAppBar(
      backgroundColor: colorBlueGray01,
      expandedHeight: 196.h,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _recommendedProductListView(context, state, _counterModel),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 0),
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 1.0, end: 0.0),
                  duration: const Duration(milliseconds: 500),
                  builder: (context, value, child) {
                    return Transform.scale(scale: 1 + value);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          const SizedBox(height: 16),
          _homeIcon(context),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _topCategoriesHeader(context,
                    title: "Siêu ưu đãi", isTimer: true),
                const SizedBox(height: 16),
                _flashDealsProduct(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPagedSliverGrid() {
    return PagedSliverGrid<int, DataProduct>(
      showNewPageProgressIndicatorAsGridChild: false,
      showNewPageErrorIndicatorAsGridChild: false,
      showNoMoreItemsIndicatorAsGridChild: false,
      pagingController: _pagingController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        childAspectRatio: childAspectRatio,
      ),
      builderDelegate: PagedChildBuilderDelegate<DataProduct>(
        noItemsFoundIndicatorBuilder: _empty,
        itemBuilder: (context, item, index) => AnimatedProductGridItem(
          index: index,
          child:
              _itemGridView(context, index: index, data: item, domain: domain),
        ),
      ),
    );
  }
}

Widget _recommendedProductListView(
    BuildContext context, HomeState state, _counterModel) {
  return ListView.builder(
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
                          backgroundColor: AppData
                              .recommendedProducts[index].buttonBackgroundColor,
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
      });
}

Widget _empty(BuildContext context) {
  return const DidntFound();
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
            routeService.pushNamed(Routes.productListPage,
                arguments: ProductListPageParams());
          },
          child: Text(
            "Xem tất cả",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: colorMainCover),
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
