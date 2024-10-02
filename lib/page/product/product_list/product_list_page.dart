import 'package:haruviet/component/error/not_found.dart';
import 'package:haruviet/component/error/not_found_v2.dart';
import 'package:haruviet/component/header/header_item.dart';
import 'package:haruviet/component/input/search_barv2.dart';
import 'package:haruviet/component/status/status_header_item.dart';
import 'package:haruviet/data/data_local/user_bloc.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/database_local/product/cart_provider_v2.dart';
import 'package:haruviet/gen/assets.gen.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/cart/models/cart_page_params.dart';
import 'package:haruviet/page/product/product_list/product_list_bloc.dart';
import 'package:haruviet/page/product/product_list/product_list_state.dart';
import 'package:haruviet/page/product/widgets/item_products_widget.dart';
import 'package:haruviet/search/search_product_category_page.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

import 'widgets/product_list_page_params.dart';

class ProductListPage extends StatefulWidget {
  final ProductListPageParams? params;

  const ProductListPage({super.key, this.params});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  // variables and functions
  final PagingController<int, DataProduct> _pagingController =
      PagingController(firstPageKey: startPage, invisibleItemsThreshold: 3);

  late String domain;
  FocusNode focusNode = FocusNode();
  late ProductListBloc bloc;
  late double childAspectRatio;
  final ItemProductWidget itemProductWidgets = ItemProductWidget();
  bool checkIsChangeListItem = false;
  @override
  void initState() {
    super.initState();

    bloc = ProductListBloc(widget.params)..getData();
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => bloc,
        ),
      ],
      child: Scaffold(
        appBar: _appbarSearch(context),
        body: MultiBlocListener(
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
            BlocListener<ProductListBloc, ProductListState>(
              listenWhen: (previous, current) =>
                  previous.currentTab != current.currentTab,
              listener: (context, state) {
                bloc.onFetch(page: startPage);
                _pagingController.refresh();
              },
            ),
          ],
          child: BlocBuilder<ProductListBloc, ProductListState>(
            builder: (context, state) {
              return RefreshIndicator(
                  onRefresh: () async {
                    _pagingController.refresh();
                    bloc.onFetch(page: startPage);
                  },
                  child: _viewDefault(context, state: state));
            },
          ),
        ),
      ),
    );
  }

  Widget _emptyData(BuildContext context) {
    return const DidntFoundV2();
  }

  Widget _viewDefault(BuildContext context, {required ProductListState state}) {
    childAspectRatio = MediaQuery.of(context).size.width /
        (MediaQuery.of(context).size.height / 1.35.h);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilterProductList(
          onTapFilter: () {},
          widgetPrice: GestureDetector(
            onTap: () {
              state.currentTab == CurrentTab.priceHigh
                  ? bloc.onChangeCurrentTab(CurrentTab.priceLow)
                  : bloc.onChangeCurrentTab(CurrentTab.priceHigh);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Giá',
                  style: textTheme.bodyMedium?.copyWith(
                      color: (state.currentTab != CurrentTab.priceHigh &&
                              state.currentTab != CurrentTab.priceLow)
                          ? colorBlack
                          : colorMain),
                ),
                spaceW4,
                SizedBox(
                  height: 24.r,
                  width: 24.r,
                  child: Image.asset(
                    (state.currentTab != CurrentTab.priceHigh &&
                            state.currentTab != CurrentTab.priceLow)
                        ? Assets.icons.filterPrice.path
                        : state.currentTab == CurrentTab.priceHigh
                            ? Assets.icons.filterLow.path
                            : Assets.icons.filterHigh.path,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
          checkIsChangeListItem: checkIsChangeListItem,
          onChangeListItem: () {
            setState(() {
              checkIsChangeListItem = !checkIsChangeListItem;
            });
          },
          key: ObjectKey(checkIsChangeListItem),
          statusSelected: state.currentTab,
          onSelect: (value) {
            bloc.onChangeCurrentTab(value);
          },
        ),
        state.newDataList == null
            ? _empty(context)
            : Expanded(
                child: checkIsChangeListItem
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: PagedGridView<int, DataProduct>(
                          pagingController: _pagingController,
                          showNewPageProgressIndicatorAsGridChild: false,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 0,
                                  crossAxisSpacing: 0,
                                  childAspectRatio: childAspectRatio),
                          builderDelegate:
                              PagedChildBuilderDelegate<DataProduct>(
                            noItemsFoundIndicatorBuilder: _empty,
                            itemBuilder: (context, item, index) {
                              return _itemGridView(
                                context,
                                index: index,
                                data: item,
                                domain: domain,
                              );
                            },
                          ),
                        ),
                      )
                    : PagedListView.separated(
                        scrollDirection: Axis.vertical,
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        pagingController: _pagingController,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        builderDelegate: PagedChildBuilderDelegate<DataProduct>(
                          noItemsFoundIndicatorBuilder: _emptyData,
                          itemBuilder: (context, item, index) {
                            return _itemRow(context,
                                data: item, index: index, domain: domain);
                          },
                        ),
                        separatorBuilder: (context, index) => const Divider(
                          color: colorBlueGray03,
                        ),
                      ),
              ),
      ],
    );
  }

  Widget _empty(BuildContext context) {
    return const DidntFound();
  }

  Widget _itemRow(
    BuildContext context, {
    required DataProduct data,
    required int index,
    required String domain,
  }) {
    return itemProductWidgets.itemRow(context,
        data: data, index: index, domain: domain);
  }

  Widget _itemGridView(
    BuildContext context, {
    required DataProduct data,
    required int index,
    required String domain,
  }) {
    return itemProductWidgets.itemGridView(context,
        data: data, index: index, domain: domain);
  }

  PreferredSizeWidget _appbarSearch(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: colorMain,
      title: AppSearchBarV2(
        hintText: 'Tìm kiếm sản phẩm',
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
