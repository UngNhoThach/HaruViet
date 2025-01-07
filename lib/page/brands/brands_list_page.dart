import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:haruviet/component/error/not_found.dart';
import 'package:haruviet/component/error/not_found_v2.dart';
import 'package:haruviet/component/input/search_barv2.dart';
import 'package:haruviet/component/loading/loading.dart';
import 'package:haruviet/data/data_local/setting_app_bloc.dart';
import 'package:haruviet/data/reponsitory/brands_repository/get_top_brands_response/data_top_brand.dart';
import 'package:haruviet/database_local/product/cart_provider_v2.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/brands/brands_list_bloc.dart';
import 'package:haruviet/page/brands/widgets/brand_item.dart';
import 'package:haruviet/page/cart/models/cart_page_params.dart';
import 'package:haruviet/page/home/widgets/scroll_to_top_widget.dart';
import 'package:haruviet/page/product/widgets/item_products_widget.dart';
import 'package:haruviet/search/search_product_category_page.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

import 'brands_list_state.dart';

class BrandsListPage extends StatefulWidget {
  const BrandsListPage({
    super.key,
  });

  @override
  State<BrandsListPage> createState() => _BrandsListPageState();
}

class _BrandsListPageState extends State<BrandsListPage> {
  // variables and functions
  final PagingController<int, DataTopBrand> _pagingController =
      PagingController(firstPageKey: startPage, invisibleItemsThreshold: 3);
  final ScrollController _scrollController = ScrollController();

  late String domain;
  late BrandsListBloc bloc;
  late double childAspectRatio;
  final ItemProductWidget itemProductWidgets = ItemProductWidget();
  bool checkIsChangeListItem = false;
  double weight = 0.0;
  double height = 0.0;

  double _previousScrollPosition = 0;

  late double _scrollThreshold; // Ngưỡng cuộn 200px

  @override
  void initState() {
    // build widget first
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenHeight = MediaQuery.of(context).size.height;
      setState(() {
        _scrollThreshold =
            screenHeight; // Gán chiều cao màn hình vào _scrollThreshold
      });
    });

    bloc = BrandsListBloc()..getData();
    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey != startPage) {
        bloc.onFetch(page: pageKey);
      }
    });
    _onScroll();

    domain = context.read<SettingAppBloc>().state.xUrl ?? '';
    super.initState();
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

  @override
  void dispose() {
    _pagingController.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    weight = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
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
        appBar: _appbarSearch(context),
        body: MultiBlocListener(
          listeners: [
            BlocListener<BrandsListBloc, BrandsListState>(
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
          child: BlocBuilder<BrandsListBloc, BrandsListState>(
            builder: (context, state) {
              return state.isLoading
                  ? const LoadingLogo()
                  : RefreshIndicator(
                      onRefresh: () async {
                        _previousScrollPosition = 0;

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

  Widget _body(BuildContext context, {required BrandsListState state}) {
    childAspectRatio = weight / (height / 1.40.h);
    return SingleChildScrollView(
        child: state.newDataList == null
            ? _empty(context)
            : MasonryGridView.count(
                physics: const BouncingScrollPhysics(),
                controller: _scrollController,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                itemCount: _pagingController.itemList?.length ?? 0,
                itemBuilder: (context, index) {
                  final item = _pagingController.itemList?[index];
                  return BrandItem(
                    width: weight * 0.44,
                    //  height: height * 0.16,
                    assetImageString: '$domain${item?.image ?? ''}',
                    //
                    itemString: item?.name ?? '',
                  );
                },
              ));
  }

  Widget _empty(BuildContext context) {
    return const DidntFound();
  }

  PreferredSizeWidget _appbarSearch(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
      title: AppSearchBarV2(
        hintText: 'Thương hiệu',
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                const begin = Offset(0.8, 0.0);
                const end = Offset.zero;
                const curve = Curves.decelerate;

                var tween = Tween(begin: begin, end: end);
                var curvedAnimation = CurvedAnimation(
                  parent: animation,
                  curve: curve,
                );

                var offsetAnimation = tween.animate(curvedAnimation);

                return SlideTransition(
                  position: offsetAnimation,
                  child: const SearchScaffold(),
                );
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
          //.then((value) => bloc.onHideBottomBar());
        },
      ),
      actions: <Widget>[
        spaceW16,
        Consumer<CartProviderV2>(
          builder: (BuildContext context, CartProviderV2 value, Widget? child) {
            return badges.Badge(
              position: badges.BadgePosition.topEnd(top: 0, end: 2),
              showBadge: value.getCounter() == 0 ? false : true,
              ignorePointer: false,
              badgeStyle: const badges.BadgeStyle(badgeColor: Colors.yellow),
              badgeContent: Text('${value.counter}'),
              child: IconButton(
                onPressed: () {
                  routeService.pushNamed(Routes.cartPage,
                      arguments: CartPageParams(isAppBar: true));
                },
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: colorWhite,
                  weight: 2.5.sp,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
