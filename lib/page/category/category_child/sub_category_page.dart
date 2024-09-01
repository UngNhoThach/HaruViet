import 'package:haruviet/component/error/not_found.dart';
import 'package:haruviet/component/error/not_found_v2.dart';
import 'package:haruviet/component/header/header_item.dart';
import 'package:haruviet/component/input/search_barv2.dart';
import 'package:haruviet/component/loading/loading.dart';
import 'package:haruviet/component/status/status_header_item.dart';
import 'package:haruviet/data/data_local/user_bloc.dart';
import 'package:haruviet/data/reponsitory/category/models/atribute_category_response/attributes_category_response.dart';
import 'package:haruviet/data/reponsitory/category/models/atribute_category_response/value_attributes.dart';
import 'package:haruviet/data/reponsitory/category/models/category_detail_response/subcategory.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/database_local/product/cart_provider.dart';
import 'package:haruviet/gen/assets.gen.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/cart/models/cart_page_params.dart';
import 'package:haruviet/page/category/category_child/sub_category_bloc.dart';
import 'package:haruviet/page/category/category_child/sub_category_state.dart';
import 'package:haruviet/page/category/category_child/widgets/filter_sub_category.dart';
import 'package:haruviet/page/home/widgets/home_icon.dart';
import 'package:haruviet/page/product/product_list/widgets/product_list_page_params.dart';
import 'package:haruviet/page/product/widgets/item_products_widget.dart';
import 'package:haruviet/page/widgets/sliver_appbar_delegate.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/search/search_product_category_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'filter/filter_product_page.dart';
import 'filter/widgets/filter_product_params.dart';
import 'widgets/sub_category_params.dart';
import 'package:badges/badges.dart' as badges;

class SubCategoryPage extends StatefulWidget {
  final CategoryParams params;
  const SubCategoryPage({super.key, required this.params});

  @override
  State<SubCategoryPage> createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  // variables and functions
  bool isInteger(num value) => (value % 1) == 0;
  final ItemProductWidget itemProductWidgets = ItemProductWidget();

  final PagingController<int, DataProduct> _pagingController =
      PagingController(firstPageKey: startPage, invisibleItemsThreshold: 3);
  late String domain;
  FocusNode focusNode = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isFocused = false;
  late SubCategoryBloc bloc;
  void _onFocusChange() {
    setState(() {
      isFocused = focusNode.hasFocus;
    });
  }

  void _openDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    focusNode.addListener(_onFocusChange);
    bloc = SubCategoryBloc(
      idCategory: widget.params.idCategory,
    )..getData();

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

    focusNode.removeListener(_onFocusChange);
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
      child: MultiBlocListener(
        listeners: [
          BlocListener<SubCategoryBloc, SubCategoryState>(
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
        child: BlocBuilder<SubCategoryBloc, SubCategoryState>(
          builder: (context, state) {
            return Scaffold(
              endDrawer: state.atributesCategoryData.isNotEmpty
                  ? _endDrawer(context,
                      atributesCategoryData: state.atributesCategoryData,
                      state: state)
                  : null,
              drawerEnableOpenDragGesture: false,
              key: _scaffoldKey,
              appBar: _appbarSearch(context),
              body: state.isLoading && state.isLoadingProduct
                  ? const LoadingLogo()
                  // _loadingData(context)
                  : NestedScrollView(
                      headerSliverBuilder: (context, innerBoxIsScrolled) => [
                        state.subcategories.isEmpty
                            ? SliverToBoxAdapter(child: space0)
                            : SliverToBoxAdapter(
                                child: _subCategory(
                                  context,
                                  subcategories: state.subcategories,
                                  domain: domain,
                                ),
                              ),
                        SliverToBoxAdapter(
                          child: _filter(
                            state: state,
                            context,
                            nameCategory: state.nameCategory,
                            isFilter: state.atributesCategoryData.isNotEmpty,
                            //  data: AtributesValue(value: 'nhothach'),
                            onTapCallback: () {},
                          ),
                        ),
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: SliverAppBarDelegate(
                            child: BlocSelector<SubCategoryBloc,
                                SubCategoryState, bool>(
                              selector: (checkFilterProductList) {
                                return checkFilterProductList
                                    .checkFilterProductList;
                              },
                              builder: (context, checkFilterProductList) {
                                return FilterProductList(
                                  onTapFilter: () {},
                                  widgetPrice: GestureDetector(
                                    onTap: () {
                                      state.currentTab == CurrentTab.priceHigh
                                          ? bloc.onChangeCurrentTab(
                                              CurrentTab.priceLow)
                                          : bloc.onChangeCurrentTab(
                                              CurrentTab.priceHigh);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Giá',
                                          style: textTheme.bodyMedium?.copyWith(
                                              color: (state.currentTab !=
                                                          CurrentTab
                                                              .priceHigh &&
                                                      state.currentTab !=
                                                          CurrentTab.priceLow)
                                                  ? colorBlack
                                                  : colorMain),
                                        ),
                                        spaceW4,
                                        SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: Image.asset(
                                            (state.currentTab !=
                                                        CurrentTab.priceHigh &&
                                                    state.currentTab !=
                                                        CurrentTab.priceLow)
                                                ? Assets.icons.filterPrice.path
                                                : state.currentTab ==
                                                        CurrentTab.priceHigh
                                                    ? Assets
                                                        .icons.filterLow.path
                                                    : Assets
                                                        .icons.filterHigh.path,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  checkIsChangeListItem:
                                      state.checkIsChangeListItem,
                                  onChangeListItem: () {
                                    bloc.onChangeCheckIsChangeListItem();
                                  },
                                  key: ObjectKey(checkFilterProductList),
                                  statusSelected: state.currentTab,
                                  onSelect: (value) {
                                    bloc.onChangeCurrentTab(value);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                      body: RefreshIndicator(
                        onRefresh: () async {
                          _pagingController.refresh();
                          bloc.onFetch(page: startPage);
                        },
                        child: state.isLoading
                            ? _loadingData(context)
                            : state.newDataList!.isEmpty
                                ? _emptyData(context)
                                : state.checkIsChangeListItem
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 16),
                                        child: CustomScrollView(
                                          slivers: [
                                            PagedSliverGrid(
                                              shrinkWrapFirstPageIndicators:
                                                  true,
                                              pagingController:
                                                  _pagingController,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                mainAxisSpacing: 12.0,
                                                crossAxisSpacing: 8.0,
                                                childAspectRatio: 0.8,
                                              ),
                                              builderDelegate:
                                                  PagedChildBuilderDelegate<
                                                      DataProduct>(
                                                noItemsFoundIndicatorBuilder:
                                                    _emptyData,
                                                itemBuilder:
                                                    (context, item, index) =>
                                                        _itemGridView(context,
                                                            index: index,
                                                            data: item,
                                                            domain: domain),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : PagedListView.separated(
                                        scrollDirection: Axis.vertical,
                                        keyboardDismissBehavior:
                                            ScrollViewKeyboardDismissBehavior
                                                .onDrag,
                                        pagingController: _pagingController,
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        builderDelegate:
                                            PagedChildBuilderDelegate<
                                                DataProduct>(
                                          noItemsFoundIndicatorBuilder:
                                              _emptyData,
                                          itemBuilder: (context, item, index) {
                                            return _itemRow(context,
                                                data: item,
                                                index: index,
                                                domain: domain);
                                          },
                                        ),
                                        separatorBuilder: (context, index) =>
                                            const Divider(
                                                color: colorBlueGray03),
                                      ),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }

  Widget _loadingData(BuildContext context) {
    return const DidntFound();
  }

  Widget _emptyData(BuildContext context) {
    return const DidntFoundV2();
  }

  Widget _endDrawer(BuildContext context,
      {required List<AtributesCategoryResponse> atributesCategoryData,
      required SubCategoryState state}) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            atributesCategoryData.isNotEmpty
                ? Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        spaceH32,
                        const Text(
                          'Lọc sản phẩm',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                              _listAttribute(
                                context,
                                atributesCategoryData: atributesCategoryData,
                              )
                            ])))
                      ]))
                : _emptyData(context),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: InkWell(
                    onTap: () {
                      bloc.onResetFilter();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          spaceW4,
                          Text(
                            'Khởi động lại',
                            style: textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey, fontSize: 13),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: InkWell(
                    onTap: () {
                      bloc.onFetch(page: startPage);
                      _closeDrawer();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          spaceW4,
                          Text(
                            'Tìm kiếm',
                            style: textTheme.bodyMedium?.copyWith(
                              color: context.colorScheme.onPrimary,
                              fontSize: 13,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // spaceH20,
          ],
        ),
      ),
    );
  }

  Widget _listAttribute(
    BuildContext context, {
    required List<AtributesCategoryResponse> atributesCategoryData,
  }) {
    return Column(
      children: atributesCategoryData
          .map((value) => _itemAttribute(
                context,
                itemAttribute: value,
              ))
          .toList(),
    );
  }

  Widget _itemAttribute(BuildContext context,
      {required AtributesCategoryResponse itemAttribute}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        spaceH20,
        Row(
          children: [
            Expanded(
                child: Text(
              itemAttribute.descriptions?.title ?? '',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: colorBlackTileItem,
                    fontWeight: FontWeight.w500,
                  ),
            )),
          ],
        ),
        spaceH8,
        _itemValueAttribute(context,
            idSubCategory: itemAttribute.slug ?? '',
            atributesValue: itemAttribute.values ?? [])
      ],
    );
  }

  Widget _itemValueAttribute(BuildContext context,
      {required String idSubCategory,
      required List<AtributesValue> atributesValue}) {
    // fix here
    return Wrap(
      //  key: ObjectKey(checkResetFilter),
      spacing: 12,
      runSpacing: 12,
      direction: Axis.horizontal,
      children: atributesValue
          .map((item) => _itemStatus(
                context,
                item.value ?? '',
                item.isFilter ?? false,
                () {
                  bloc.onSelectAttributeValue(
                      atributesValue: item, idSubCategory: idSubCategory);
                },
              ))
          .toList(),
    );
  }

  Widget _itemStatus(
      BuildContext context, String value, bool isClick, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        decoration: BoxDecoration(
          border: isClick
              ? Border.all(
                  width: 1,
                  color: colorWhite,
                )
              : Border.all(
                  width: 1,
                  color: const Color.fromARGB(255, 225, 223, 223),
                ),
          color: isClick ? colorMain : Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: textTheme.labelMedium?.copyWith(
                  color: isClick ? colorWhite : Colors.grey[600],
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _subCategory(BuildContext context,
      {required List<Subcategory> subcategories, required String domain}) {
    final List<ChildCategory> categories = subcategories.map((subcategory) {
      return ChildCategory(
        assetImageString: '$domain${subcategory.image ?? ''}',
        itemString: subcategory.descriptions?.title ?? '',
        onTap: () {
          routeService.pushNamed(Routes.productListPage,
              arguments: ProductListPageParams(
                  onReload: () {},
                  categoryID: widget.params.idCategory,
                  subCategoryID: subcategory.id ?? ''));
        },
        destinationWidget: null,
      );
    }).toList();

    return Container(
      color: colorBlueGray02.withOpacity(0.5),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            height: 80.h, // Adjust height based on the number of items
            child: GridView.builder(
              physics: categories.length > 4
                  ? const AlwaysScrollableScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 4 items per row
                childAspectRatio: 1.0,
                mainAxisSpacing: 12,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return categories[index];
              },
            ),
          ),
        ],
      ),
    );
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
        Consumer<CartProvider>(
          builder: (BuildContext context, CartProvider value, Widget? child) {
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

  List<Widget> _itemAddList(BuildContext context,
      {required String title,
      required String value,
      required VoidCallback onTapCallback}) {
    return [
      Container(
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
        decoration: BoxDecoration(
          color: colorGray02.withOpacity(0.8),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                "$title: $value",
                style: textTheme.bodySmall
                    ?.copyWith(color: colorBlack, fontWeight: FontWeight.bold),
              ),
            ),
            spaceW4,
            InkWell(
              onTap: () {
                // delete here
                bloc.onDeleteItemFilter(
                    AtributesValue(value: value, lang: title),
                    isDeleteAll: false);
              },
              child: const Icon(
                Icons.close,
                color: colorMain,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    ];
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

  Widget _itemRow(
    BuildContext context, {
    required DataProduct data,
    required int index,
    required String domain,
  }) {
    return itemProductWidgets.itemRow(context,
        data: data, index: index, domain: domain);
  }

  Widget _filter(
    BuildContext context, {
    String? nameCategory,
    required bool isFilter,
    required SubCategoryState state,
    required void Function() onTapCallback,
    //     required AtributesValue data
  }) {
    return BlocSelector<SubCategoryBloc, SubCategoryState, bool>(
      selector: (checkFilterProductList) {
        return checkFilterProductList.checkFilterProductList;
      },
      builder: (context, checkFilterProductList) {
        return Row(
          key: ObjectKey(checkFilterProductList),
          children: [
            Expanded(
              child: FilterSubCategory(
                onTapFilter: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FilterProductPage(
                              params: FilterProductParams(
                                onReturnAtributesCategoryData:
                                    (atributesCategoryDataSave) {
                                  if (atributesCategoryDataSave == null ||
                                      atributesCategoryDataSave.isEmpty) {
                                  } else {
                                    bloc.onSaveDataReturn(
                                        atributesCategoryDataSave:
                                            atributesCategoryDataSave);
                                  }
                                },
                                filteredCategories: state.filteredCategories,
                                onReturnResult: (result) {
                                  if (result == null ||
                                      result == {} ||
                                      result.isEmpty) {
                                    bloc.onDeleteItemFilter(
                                        isDeleteAll: true, AtributesValue());
                                  } else {
                                    bloc.onSaveResult(
                                        filteredCategories: result);
                                  }
                                },
                                atributesCategoryData:
                                    state.atributesCategoryDataSave,
                                onReload: () {},
                              ),
                            )),
                  );
                },
                widget: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: state.filterValuesName.isEmpty ? 0 : 12),
                  child: Builder(
                    builder: (context) {
                      // Tạo danh sách các widget từ _itemAddList
                      List<Widget> itemWidgets =
                          state.filterValuesName.entries.expand((item) {
                        return _itemAddList(
                          context,
                          title: item.key,
                          value: item.value,
                          onTapCallback: () {},
                        );
                      }).toList();

                      // Kiểm tra nếu số lượng widget >= 5
                      if (itemWidgets.length >= 5) {
                        // Cắt bớt số lượng widget hiển thị xuống còn 5
                        itemWidgets = itemWidgets.take(5).toList();

                        // Thêm nút "Xem thêm"
                        itemWidgets.add(
                          GestureDetector(
                            onTap: () {
                              // Thực hiện hành động xem thêm
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4.h, horizontal: 6.w),
                              decoration: BoxDecoration(
                                color: context.colorScheme.primary,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Xem thêm",
                                    style: textTheme.bodySmall?.copyWith(
                                        color: colorWhite,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  spaceW4,
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: colorWhite,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else if (itemWidgets.length >= 2) {
                        // Nếu số lượng widget >= 2, thêm nút "Xoá tất cả"
                        itemWidgets.add(
                          GestureDetector(
                            onTap: () {
                              bloc.onDeleteItemFilter(AtributesValue(),
                                  isDeleteAll: true);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4.h, horizontal: 6.w),
                              decoration: BoxDecoration(
                                color: colorMain,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "Xoá tất cả",
                                      style: textTheme.bodySmall?.copyWith(
                                          color: colorWhite,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  spaceW4,
                                  const Icon(
                                    Icons.close,
                                    color: colorWhite,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }

                      return Wrap(
                        spacing: 12.w, // Khoảng cách giữa các widget
                        runSpacing: 12.h, // Khoảng cách giữa các hàng
                        children: itemWidgets,
                      );
                    },
                  ),
                ),
                // fix here
                isFilter: state.isFilter,
                nameCategory: nameCategory,
                onTap: () {
                  _openDrawer();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SliverAppBarTabDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSize child;

  _SliverAppBarTabDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
