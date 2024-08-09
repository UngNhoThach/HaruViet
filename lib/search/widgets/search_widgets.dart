import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haruviet/component/shimer/image_product_shimer.dart';
import 'package:haruviet/data/reponsitory/product/models/data_search_default_response/search_category.dart';
import 'package:haruviet/data/reponsitory/product/models/data_search_default_response/search_product.dart';
import 'package:haruviet/database_local/suggestion_data_search/models/suggestion_data_search_model.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/category/category_child/widgets/sub_category_params.dart';
import 'package:haruviet/page/product/detail/widgets/product_detail_params.dart';
import 'package:haruviet/resources/routes.dart';
import 'package:haruviet/search/search_product_category_bloc.dart';
import 'package:haruviet/search/search_product_category_state.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:haruviet/utils/commons.dart';

class SearchWidgets {
  // Constructor
  SearchWidgets();

  // Widget ViewSearch
  Widget viewSearch(BuildContext context,
      {required SearchProductCategoryState stateSearchList,
      required SearchProductCategoryBloc blocSearchProductCategory,
      required TextEditingController searchController,
      required String domain}) {
    return stateSearchList.categorySearchList.isEmpty &&
            stateSearchList.productSearchList.isEmpty
        ? emptyView(context,
            blocSearchProductCategory: blocSearchProductCategory,
            searchController: searchController)
        : BlocSelector<SearchProductCategoryBloc, SearchProductCategoryState,
            List<SearchCategory>>(
            selector: (state) {
              return state.categorySearchList;
            },
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: stateSearchList.productSearchList.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text('Sản phẩm',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: colorMain,
                                            fontSize: 18)),
                              ),
                            ],
                          )
                        : space0,
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index.isOdd) {
                          return const Divider(
                            color: colorBlueGray02,
                          );
                        }
                        final itemIndex = index ~/ 2;
                        if (itemIndex <
                            stateSearchList.productSearchList.length) {
                          final item =
                              stateSearchList.productSearchList[itemIndex];
                          return itemSearchProducts(context,
                              data: item, index: itemIndex, domain: domain);
                        }
                        return space0;
                      },
                      childCount: stateSearchList.productSearchList.length * 2 -
                          1, // Account for dividers
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: stateSearchList.categorySearchList.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(
                                color: colorBlueGray03,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 16, top: 16, bottom: 8, left: 16),
                                child: Text('Danh mục',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: colorMain,
                                            fontSize: 18)),
                              ),
                            ],
                          )
                        : space0,
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Wrap(
                        spacing: 8.w,
                        runSpacing: 8.w,
                        children: List.generate(
                          stateSearchList.categorySearchList.length,
                          (index) {
                            final item =
                                stateSearchList.categorySearchList[index];
                            return itemSearchCategories(
                              context,
                              data: item,
                              index: index,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
  }

  // Widget ItemSearchProducts
  Widget itemSearchProducts(BuildContext context,
      {required SearchProduct data,
      required int index,
      required String domain}) {
    return GestureDetector(
      onTap: () {
        routeService
            .pushNamed(Routes.productDetailPage,
                arguments: ProductDetailParams(idProduct: data.id ?? ''))
            .then(
          (value) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
        child: Row(
          children: [
            ClipRRect(
              child: CachedNetworkImage(
                fadeOutDuration: const Duration(seconds: 3),
                imageUrl: '$domain${data.image}',
                width: 40,
                height: 40,
                placeholder: (context, url) => const ImageProductShimer(
                  width: 40,
                  height: 40,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            spaceW12,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${data.price?.finalSearchPriceStr}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colorMain,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      data.price?.promotionPercent != 0
                          ? Text(
                              '${data.price?.searchpriceStr}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: colorItemCover,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                            )
                          : space0
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.name ?? '',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: colorBlackTileItem,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget ItemSearchCategories
  Widget itemSearchCategories(BuildContext context,
      {required SearchCategory data, required int index}) {
    return FilterChip(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
        6.r,
      )),
      label: Text(
        data.name ?? '',
        style: textTheme.bodyMedium?.copyWith(
          color: colorPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      onSelected: (bool selected) {
        if (selected) {
          routeService.pushNamed(Routes.subCategoryPage,
              arguments: CategoryParams(idCategory: data.id ?? ''));
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      selectedColor: colorWhite,
      backgroundColor: colorWhite,
      showCheckmark: false,
    );
  }

  // Widget EmptyView
  Widget emptyView(BuildContext context,
      {required TextEditingController searchController,
      required SearchProductCategoryBloc blocSearchProductCategory}) {
    return BlocSelector<SearchProductCategoryBloc, SearchProductCategoryState,
        List<SuggestionDataSearchModel>>(
      selector: (data) {
        return data.searchDataList;
      },
      builder: (context, data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final reversedData = List.from(data.reversed);
            final value = reversedData[index].value;
            return InkWell(
              onTap: () {
                searchController.text = value;
                blocSearchProductCategory.onGetDataSearch(value);
              },
              borderRadius: BorderRadius.circular(8.0.r),
              splashColor: colorGray03, // Hiệu ứng ripple
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                child: Text(
                  value,
                  style: textTheme.titleMedium?.copyWith(
                    color: colorSecondary04,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
