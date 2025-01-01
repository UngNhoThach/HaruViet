import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haruviet/base/base_state.dart';
import 'package:haruviet/component/shimer/image_product_shimer.dart';
import 'package:haruviet/component/shimer/shimer.dart';
import 'package:haruviet/connection.dart';
import 'package:haruviet/data/data_local/setting_app_bloc.dart';
import 'package:haruviet/data/reponsitory/category/models/list_category_response/data_category.dart';
import 'package:haruviet/data/reponsitory/category/models/list_category_response/subcategory.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/category/category_bloc.dart';
import 'package:haruviet/page/category/category_state.dart';
import 'package:haruviet/page/category/widgets/category_paga_params.dart';
import 'package:haruviet/page/home/widgets/drawer_list_page.dart';
import 'package:haruviet/page/product/product_list/widgets/product_list_page_params.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:badges/badges.dart' as badges;
import 'package:haruviet/utils/commons.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key, required this.params});
  final CategoryPageParams params;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // variables and functions

  // check connection
  late StreamSubscription connectionChangeStream;
  bool isOffline = false;

  final PagingController<int, DataCategory> _pagingController =
      PagingController(firstPageKey: startPage, invisibleItemsThreshold: 3);
  FocusNode focusNode = FocusNode();

  late CategoryBloc bloc;
  late String domain;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

// check connection change
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);
    if (!connectionStatus.hasConnection) {
      isOffline = !connectionStatus.hasConnection;
    } else {}

    bloc = CategoryBloc()..getData();

    domain = context.read<SettingAppBloc>().state.xUrl ?? '';
    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey != startPage) {
        bloc.onFetch(page: pageKey);
      }
    });
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
    });
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
        drawer: DrawerListPage(
          name: bloc.state.userInfoLogin?.name ?? "",
          url: bloc.state.userInfoLogin?.avatar ?? "",
          isLogin: bloc.state.userInfoLogin != null
              ? bloc.state.userInfoLogin!.isLogin
              : false,
        ),
        body: BlocListener<CategoryBloc, CategoryState>(
          listenWhen: (previous, current) =>
              previous.newListCategory != current.newListCategory,
          listener: (context, state) {
            if (state.currentPage == startPage) {
              _pagingController.refresh();
            }
            if (state.canLoadMore) {
              _pagingController.appendPage(
                state.newListCategory ?? [],
                state.currentPage + 1,
              );
            } else {
              _pagingController.appendLastPage(state.newListCategory ?? []);
            }
          },
          child: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              return state.isLoading
                  ? const LoadingWidget()
                  : ((state.listCategory == null ||
                              state.listCategory!.isEmpty) &&
                          isOffline)
                      ? const Center(
                          child: Text('Kiểm tra kết nối!'),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            _pagingController.refresh();
                            bloc.onFetch(page: startPage);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Wrapping the entire structure to constrain the width of the category list panel
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                color: Colors
                                    .grey[200], // Optional background color
                                child: PagedListView.separated(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.vertical,
                                  keyboardDismissBehavior:
                                      ScrollViewKeyboardDismissBehavior.onDrag,
                                  pagingController: _pagingController,
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  builderDelegate:
                                      PagedChildBuilderDelegate<DataCategory>(
                                    noItemsFoundIndicatorBuilder: _shimmer,
                                    itemBuilder: (context, item, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          bloc.onChangeSelecCategories(
                                              selectedCategory: index);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8.w,
                                            vertical: 16.h,
                                          ),
                                          decoration: state.selectedCategory ==
                                                  index
                                              ? BoxDecoration(
                                                  border: Border(
                                                    left: BorderSide(
                                                        width: 6.0.w,
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                  ),
                                                  color: Colors.white,
                                                )
                                              : const BoxDecoration(
                                                  color: colorBlueGray01,
                                                ),
                                          child: Text(
                                            item.descriptions?.title ?? '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  color: colorBlackTileItem,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const Divider(
                                    height: 1,
                                    color: colorBlueGray03,
                                  ),
                                ),
                              ),

                              // Right panel with Expanded
                              Expanded(
                                child: Container(
                                  color: colorWhite,
                                  child: _category(
                                    context,
                                    subcategory: state
                                            .listCategory![
                                                state.selectedCategory]
                                            .subcategories ??
                                        [],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
            },
          ),
        ),
      ),
    );
  }

  Widget _shimmer(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => ShimmerEffect(
        child: Container(
          height: 50.h,
          decoration: BoxDecoration(
            color: colorWhite,
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
      separatorBuilder: (context, index) => spaceH12,
      itemCount: 12,
    );
  }

  Widget _category(
    BuildContext context, {
    required List<Subcategory> subcategory,
  }) {
    return Container(
      padding: EdgeInsets.only(top: 16.h, bottom: 40.h, left: 6.w, right: 6.w),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: subcategory.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              routeService.pushNamed(Routes.productListPage,
                  arguments: ProductListPageParams(
                      onReload: () {},
                      //    categoryID: widget.params.idCategory,
                      subCategoryID: subcategory[index].id ?? ''));
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Wrap(alignment: WrapAlignment.center, children: [
                    CachedNetworkImage(
                      fadeOutDuration: const Duration(seconds: 2),
                      imageUrl: '$domain${subcategory[index].image ?? ''}',
                      width: 48.w,
                      height: 48.h,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.r),
                      child: Text(
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        subcategory[index].descriptions?.title ?? '',
                        style: textTheme.bodySmall?.copyWith(
                            color: colorBlack, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
