import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:haruviet/component/error/not_found_v2.dart';
import 'package:haruviet/component/header/header_item.dart';
import 'package:haruviet/component/input/search_bar.dart';
import 'package:haruviet/component/error/not_found.dart';
import 'package:haruviet/component/shimer/image_product_shimer.dart';
import 'package:haruviet/data/data_local/user_bloc.dart';
import 'package:haruviet/data/reponsitory/category/models/category_detail_response/subcategory.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/cart/models/cart_page_params.dart';
import 'package:haruviet/page/category/category_child/sub_category_bloc.dart';
import 'package:haruviet/page/category/category_child/sub_category_state.dart';
import 'package:haruviet/page/home/widgets/count_dount.dart';
import 'package:haruviet/page/home/widgets/home_icon.dart';
import 'package:haruviet/page/product/detail/product_deatail_page.dart';
import 'package:haruviet/page/product/detail/widgets/product_detail_params.dart';
import 'package:haruviet/search/search_product_category_bloc.dart';
import 'package:haruviet/search/search_product_category_state.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/search/widgets/search_widgets.dart';
import 'package:haruviet/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'widgets/sub_category_params.dart';

class SubCategoryPage extends StatefulWidget {
  final CategoryParams params;
  const SubCategoryPage({super.key, required this.params});

  @override
  State<SubCategoryPage> createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  // variables and functions
  bool isInteger(num value) => (value % 1) == 0;
  TextEditingController searchController = TextEditingController();
  final SearchWidgets searchWidgets = SearchWidgets();

  bool checkIsChangeListItem = false;
  late String domain;
  FocusNode focusNode = FocusNode();
  bool isFocused = false;
  late SubCategoryBloc bloc;
  late SearchProductCategoryBloc blocSearchProductCategory;
  void _onFocusChange() {
    setState(() {
      isFocused = focusNode.hasFocus;
    });
  }

  @override
  void initState() {
    super.initState();
    focusNode.addListener(_onFocusChange);
    blocSearchProductCategory = SearchProductCategoryBloc()..getData();
    bloc = SubCategoryBloc(
      idCategory: widget.params.idCategory,
    )..getData();

    domain = context.read<UserBloc>().state.subDomain ?? '';
    // blocSearch = context.read<SearchProductCategoryBloc>();
  }

  @override
  void dispose() {
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
        BlocProvider(
          create: (context) => blocSearchProductCategory,
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<SubCategoryBloc, SubCategoryState>(
            listenWhen: (previous, current) =>
                previous.newDataList != current.newDataList,
            listener: (context, state) {
              // if (state.currentPage == startPage) {
              //   _pagingController.refresh();
              // }
              // if (state.canLoadMore) {
              //   _pagingController.appendPage(
              //     state.newDataList ?? [],
              //     state.currentPage + 1,
              //   );
              // } else {
              //   _pagingController.appendLastPage(state.newDataList ?? []);
              // }
            },
          ),
        ],
        child: BlocBuilder<SubCategoryBloc, SubCategoryState>(
          builder: (context, state) {
            return BlocBuilder<SearchProductCategoryBloc,
                SearchProductCategoryState>(
              builder: (context, stateSearch) {
                return Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back, color: colorWhite),
                      onPressed: isFocused
                          ? () {
                              setState(() {
                                searchController.text = '';
                                isFocused = false;
                                FocusScope.of(context).unfocus(); //
                              });
                            }
                          : () {
                              context.justBack();
                            },
                    ),
                    centerTitle: true,
                    title: _buildSearchField(),
                    backgroundColor: colorMain,
                    actions: isFocused
                        ? null
                        : <Widget>[
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
                                  checkIsChangeListItem =
                                      !checkIsChangeListItem;
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
                  body: isFocused
                      ? GestureDetector(
                          onTap: () =>
                              FocusManager.instance.primaryFocus?.unfocus(),
                          child: viewSearch(context,
                              domain: domain,
                              blocSearchProductCategory:
                                  blocSearchProductCategory,
                              searchController: searchController,
                              stateSearchList: stateSearch))
                      : RefreshIndicator(
                          onRefresh: () async {
                            bloc.getData();
                            //bloc.onFetch(page: startPage);
                          },
                          child: state.isLoading
                              ? _loadingData(context)
                              : (state.subcategories.isEmpty &&
                                      state.datatList.isEmpty)
                                  ? _emptyData(context)
                                  : _viewDefault(context, state: state)),
                );
              },
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

  Widget _viewDefault(BuildContext context, {required SubCategoryState state}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // FilterProductList(
        //   statusSelected: state.currentTab,
        //   onSelect: (value) {
        //     bloc.onChangeCurrentTab(value);
        //   },
        // ),
        state.subcategories.isNotEmpty
            ? _subCategory(context,
                subcategories: state.subcategories, domain: domain)
            : space0,

        Expanded(
            child:
                // checkIsChangeListItem
                //     ?
                Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = state.datatList[index];
                    return _item(context, index: index, data: item);
                  },
                  childCount: state.datatList.length,
                ),
              ),
            ],
          ),
        )
            // : PagedListView.separated(
            //     scrollDirection: Axis.vertical,
            //     keyboardDismissBehavior:
            //         ScrollViewKeyboardDismissBehavior.onDrag,
            //     shrinkWrap: true,
            //     physics: const ClampingScrollPhysics(),
            //     builderDelegate: PagedChildBuilderDelegate<DataProduct>(
            //       noItemsFoundIndicatorBuilder: _empty,
            //       itemBuilder: (context, item, index) {
            //         return _item(context, index: index, data: item);
            //       },
            //     ),
            //     separatorBuilder: (context, index) => const Divider(
            //       color: colorBlueGray03,
            //     ),
            //   ),
            ),
      ],
    );
  }

  Widget viewSearch(BuildContext context,
      {required String domain,
      required SearchProductCategoryBloc blocSearchProductCategory,
      required TextEditingController searchController,
      required SearchProductCategoryState stateSearchList}) {
    return searchWidgets.viewSearch(context,
        domain: domain,
        stateSearchList: stateSearchList,
        blocSearchProductCategory: blocSearchProductCategory,
        searchController: searchController);
  }

  Widget _subCategory(BuildContext context,
      {required List<Subcategory> subcategories, required String domain}) {
    final List<ChildCategory> categories = subcategories.map((subcategory) {
      return ChildCategory(
        assetImageString:
            '$domain${subcategory.image ?? ''}', // Assuming this property exists in Subcategory
        itemString: subcategory.descriptions?[0].title ??
            '', // Assuming this property exists in Subcategory
        onTap: () {
          bloc.getData(idCategorySub: subcategory.id);
        },
        destinationWidget: null, // You can customize this based on your needs
      );
    }).toList();

    return Column(
      children: [
        spaceH16,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: categories.length > 4
              ? 164
              : 82, // Adjust height based on the number of items
          child: GridView.builder(
            physics: categories.length > 8
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
        spaceH16,
        const Divider(
          thickness: 2.0,
          height: 0,
        ),
      ],
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
                    (data.descriptions == null)
                        ? space0
                        : Text(
                            data.descriptions?.name ?? '',
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

  Widget _buildSearchField() {
    return AppSearchBar(
      focusNode: focusNode,
      hintText: 'Tìm kiếm sản phẩm',
      controller: searchController,
      onChanged: (keyword) {
        setState(() {
          blocSearchProductCategory.onKeywordChanged(keyword: keyword);

          isFocused != true ? keyword = '' : {};
        });
      },
    );
  }
}
