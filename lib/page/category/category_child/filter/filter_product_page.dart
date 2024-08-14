import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haruviet/component/error/not_found_v2.dart';
import 'package:haruviet/component/loading/loading.dart';
import 'package:haruviet/data/reponsitory/category/models/atribute_category_response/attributes_category_response.dart';
import 'package:haruviet/data/reponsitory/category/models/atribute_category_response/value_attributes.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:flutter/material.dart';
import 'package:haruviet/theme/typography.dart';

import 'filter_product_bloc.dart';
import 'filter_product_state.dart';
import 'widgets/filter_product_params.dart';

class FilterProductPage extends StatefulWidget {
  const FilterProductPage({
    super.key,
    required this.params,
  });
  final FilterProductParams params;

  @override
  State<FilterProductPage> createState() => _FilterProductPageState();
}

class _FilterProductPageState extends State<FilterProductPage> {
  // variables and functions

  late FilterProductBloc bloc;
  late String domain;

  @override
  void initState() {
    super.initState();

    bloc = FilterProductBloc(params: widget.params)..getData();
  }

  @override
  void dispose() {
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
      child: BlocListener<FilterProductBloc, FilterProductState>(
        listener: (context, state) {},
        child: BlocBuilder<FilterProductBloc, FilterProductState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: colorBlack,
                  ),
                  onPressed: () {
                    context.justBack();
                  },
                ),
                centerTitle: true,
                elevation: 0.0,
                backgroundColor: colorGray02,
                title: Text(
                  'Bộ lọc nâng cao',
                  style: textTheme.titleLarge?.copyWith(
                      color: colorBlack, fontWeight: FontWeight.bold),
                ),
              ),
              bottomNavigationBar: Container(
                  color: colorGray01,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 5,
                        child: GestureDetector(
                          onTap: () {
                            bloc.onResetFilters(
                                allCategories: state.atributesCategoryData);
                          },
                          child: Container(
                            height: 36.h,
                            decoration: BoxDecoration(
                              color: colorWhite,
                              border: Border.all(color: colorGray02),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                spaceW16,
                                const Text('Bỏ chọn',
                                    style: TextStyle(
                                        color: colorMain,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: GestureDetector(
                          onTap: () async {
                            if (state.filteredCategories == null ||
                                state.filteredCategories == {} ||
                                state.filteredCategories!.isEmpty) {
                              widget.params
                                  .onReturnResult(state.filteredCategories);
                              widget.params.onReturnAtributesCategoryData([]);
                            } else {
                              widget.params
                                  .onReturnResult(state.filteredCategories);
                              widget.params.onReturnAtributesCategoryData(
                                  state.atributesCategoryData);
                            }
                            context.justBack();
                          },
                          child: Container(
                            height: 36.h,
                            decoration: BoxDecoration(
                              color: colorPrimary,
                              border: Border.all(color: colorGray02),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                spaceW16,
                                const Text('Xem kết quả',
                                    style: TextStyle(
                                        color: colorWhite,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              body: state.isLoading
                  ? const LoadingLogo()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 500.h, // Bạn có thể thay đổi kích thước này
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                    child: SingleChildScrollView(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                      _listAttribute(
                                        context,
                                        atributesCategoryData:
                                            state.atributesCategoryData,
                                      )
                                    ])))
                              ],
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

  Widget _listAttribute(
    BuildContext context, {
    required List<AtributesCategoryResponse> atributesCategoryData,
  }) {
    return Column(
      children: atributesCategoryData
          .map((value) => _itemAttribute(context,
              itemAttribute: value, allCategories: atributesCategoryData))
          .toList(),
    );
  }

  Widget _itemAttribute(BuildContext context,
      {required AtributesCategoryResponse itemAttribute,
      required List<AtributesCategoryResponse> allCategories}) {
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
                    fontWeight: FontWeight.w600,
                  ),
            )),
          ],
        ),
        spaceH8,
        _itemValueAttribute(context,
            idSubCategory: itemAttribute.slug ?? '',
            atributesValue: itemAttribute.values ?? [],
            allCategories: allCategories,
            category: itemAttribute)
      ],
    );
  }

  Widget _itemValueAttribute(BuildContext context,
      {required String idSubCategory,
      required List<AtributesValue> atributesValue,
      required AtributesCategoryResponse category,
      required List<AtributesCategoryResponse> allCategories}) {
    return Wrap(
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
                      category: category,
                      selectedValue: item,
                      allCategories: allCategories);
                  // bloc.onSelectAttributeValue(
                  //     atributesValue: item, idSubCategory: idSubCategory);
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

  Widget _emptyData(BuildContext context) {
    return const DidntFoundV2();
  }
}
