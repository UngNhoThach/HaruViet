import 'package:haruviet/api/services/products/models/get_list_product_request.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/component/status/status_header_item.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/category/category_repository.dart';
import 'package:haruviet/data/reponsitory/category/models/atribute_category_response/attributes_category_response.dart';
import 'package:haruviet/data/reponsitory/category/models/atribute_category_response/value_attributes.dart';
import 'package:haruviet/data/reponsitory/category/models/category_detail_response/subcategory.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/data/reponsitory/product/product_repository.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/page/category/category_child/sub_category_state.dart';
import 'package:flutter/foundation.dart';

// SubCategoryBloc
class SubCategoryBloc extends BaseBloc<SubCategoryState> {
  final String idCategory;
  SubCategoryBloc({required this.idCategory}) : super(const SubCategoryState());
  final CategoryRepository _categoryRepository = CategoryRepository();

  final ProductRepository _productRepository = ProductRepository();

  onChangeFirstTimeLoadinPage(bool firtTimeLoadingPage) {
    emit(state.copyWith(firtTimeLoadingPage: firtTimeLoadingPage));
  }

  getData() async {
    emit(state.copyWith(isLoading: true, isLoadingProduct: true));
    await onResetFilter();

    // if (state.subcategories.isNotEmpty &&
    //     state.atributesCategoryData.isNotEmpty ) {
    //   onFetch(page: startPage);
    //   return;
    // }
    try {
      // checkListNotProduct
      List<Subcategory> subcategories = [];
      List<AtributesCategoryResponse> atributesCategoryData = [];

      final List<AtributesValue> attributesSelected = [];

      // attributesSelected
      final categoryDetailData =
          await _categoryRepository.getDetailCategoryRP(idCategory: idCategory);

      subcategories.addAll(categoryDetailData.category?.subcategories ?? []);
      final userInfoLogin = await Preference.getUserInfo();
      final nameCategory =
          categoryDetailData.category?.descriptions?.title ?? '';
      atributesCategoryData
          .addAll(categoryDetailData.filterableAttributes ?? []);

      emit(state.copyWith(
        subcategories: subcategories,
        userInfoLogin: userInfoLogin,
        isFilter: atributesCategoryData.isEmpty ? false : true,
        //    attributesSelected: attributesSelected,
        atributesCategoryData: atributesCategoryData,
        atributesCategoryDataSave: atributesCategoryData,
        nameCategory: nameCategory,
        isLoadingProduct: false,
      ));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      emit(state.copyWith(
          viewState: ViewState.error, errorMsg: error.toString()));
    }

    onFetch(page: startPage);
  }

  void onSelectAttributeValue(
      {required AtributesValue atributesValue, required String idSubCategory}) {
    final List<AtributesValue> updatedAttributesSelected =
        List.from(state.attributesSelected);

    for (var attribute in updatedAttributesSelected) {
      if (attribute.id == atributesValue.id) {
        if (attribute.isFilter == false || attribute.isFilter == null) {
          attribute.isFilter = true;
          emit(state.copyWith(
            checkResetFilter: true,
          ));
          attribute.idSubCategory = idSubCategory;
        } else {
          attribute.isFilter = false;
        }
      }
    }

    emit(state.copyWith(attributesSelected: updatedAttributesSelected));
  }

  onReset() {
    onFetch(page: startPage);
  }

  onResetFilter() {
    emit(state.copyWith(
        filterValues: {}, filterValuesName: {}, filteredCategories: {}));
  }

  onFetch({
    required int page,
  }) async {
    // await onGetFilters();

    try {
      emit(state.copyWith(
        isLoading: true,
      ));
      List<DataProduct> updatedDataList = [];

      if (page == startPage) {
        emit(
          state.copyWith(
            newDataList: null,
            canLoadMore: false,
            datatList: updatedDataList,
          ),
        );
      } else {
        updatedDataList = List<DataProduct>.from(state.datatList);
      }
      final productList = await _productRepository.getListProductsRP(
        request: GetListProductRequest(
            paegNumber: page,
            pageSize: state.limit,
            category: idCategory,
            sort: state.currentTab.value,
            filters: state.filterValues),
      );

      updatedDataList.addAll(productList.data ?? []);

      final maxLoadMore = ((productList.total ?? 0) / state.limit).floor();
      final canLoadMore = page <= maxLoadMore;
      emit(state.copyWith(
        datatList: updatedDataList,
        newDataList: productList.data,
        currentPage: page,
        canLoadMore: canLoadMore,
      ));

      emit(state.copyWith(
        isLoading: false,
      ));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      emit(state.copyWith(
          viewState: ViewState.error, errorMsg: error.toString()));
    }
  }

  // onchange current tab
  onChangeCurrentTab(CurrentTab currentTab) async {
    emit(state.copyWith(
      currentTab: currentTab,
      checkResetFilter: true,
    ));
    await onUpdateResult();
    await onFetch(page: startPage);
  }

  onUpdateResult() {
    emit(state.copyWith(
        filterValues: convertFilteredCategoriesToResultMap(
            filteredCategories: state.filteredCategories),
        filterValuesName: convertSaveNameResult(
          filteredCategories: state.filteredCategories,
        ),
        checkFilterProductList: !state.checkFilterProductList));
  }

  onChangeCheckIsChangeListItem() {
    emit(state.copyWith(
        checkIsChangeListItem: !state.checkIsChangeListItem,
        checkFilterProductList: !state.checkFilterProductList));
  }

  onSaveDataReturn(
      {required List<AtributesCategoryResponse>
          atributesCategoryDataSave}) async {
    emit(state.copyWith(
      atributesCategoryDataSave: atributesCategoryDataSave,
    ));
    // await onUpdateResult();
  }

  onSaveResult(
      {required Map<AtributesCategoryResponse, AtributesValue>
          filteredCategories}) async {
    emit(state.copyWith(filteredCategories: filteredCategories));
    await onFetFilter();
  }

  onFetFilter() async {
    await onUpdateResult();
    await onFetch(page: startPage);
  }

  Map<String, String>? convertFilteredCategoriesToResultMap(
      {required Map<AtributesCategoryResponse, AtributesValue>?
          filteredCategories}) {
    // Kiểm tra nếu filteredCategories null hoặc trống
    if (filteredCategories == null || filteredCategories.isEmpty) {
      return null;
    }

    // Khởi tạo một Map rỗng để lưu kết quả
    Map<String, String> resultMap = {};

    // Duyệt qua filteredCategories
    filteredCategories.forEach((category, value) {
      // Kiểm tra nếu giá trị có isFilter == true
      if (value.isFilter == true) {
        // Gán slug của AtributesCategoryResponse và id của AtributesValue vào resultMap
        if (category.slug != null && value.id != null) {
          resultMap[category.slug!] = value.id ?? '';
        }
      }
    });

    // Trả về resultMap
    return resultMap.isNotEmpty ? resultMap : null;
  }

  Map<String, String>? convertSaveNameResult(
      {required Map<AtributesCategoryResponse, AtributesValue>?
          filteredCategories}) {
    // Kiểm tra nếu filteredCategories null hoặc trống
    if (filteredCategories == null || filteredCategories.isEmpty) {
      return null;
    }

    // Khởi tạo một Map rỗng để lưu kết quả
    Map<String, String> resultMap = {};

    // Duyệt qua filteredCategories
    filteredCategories.forEach((category, value) {
      // Kiểm tra nếu giá trị có isFilter == true
      if (value.isFilter == true) {
        // Gán slug của AtributesCategoryResponse và id của AtributesValue vào resultMap
        if (category.slug != null && value.id != null) {
          resultMap[category.slug!] = value.value ?? '';
        }
      }
    });

    // Trả về resultMap
    return resultMap.isNotEmpty ? resultMap : null;
  }

// filterValuesName
  String getIdFromCombinedValue(String combinedValue) {
    List<String> parts = combinedValue.split(';');
    if (parts.isNotEmpty) {
      return parts[0]; // Phần value.id
    } else {
      throw Exception('Combined value does not contain a valid id');
    }
  }

  //
  String getNameFromCombinedValue(String combinedValue) {
    List<String> parts = combinedValue.split(';');
    if (parts.length > 1) {
      return parts[1]; // Phần value.name
    } else {
      throw Exception('Combined value does not contain a valid name');
    }
  }

  Future<void> onDeleteItemFilter(AtributesValue valueToRemove,
      {bool isDeleteAll = false}) async {
    if (isDeleteAll) {
      emit(state.copyWith(
        filterValues: {},
        filterValuesName: {},
        filteredCategories: {},
        atributesCategoryDataSave: state.atributesCategoryData,
        checkFilterProductList: !state.checkFilterProductList,
      ));
    } else {
      // Xoá item từ filterValues và filterValuesName
      final updatedFilterValues = Map<String, String>.from(state.filterValues)
        ..removeWhere((key, value) => key == valueToRemove.lang);
      final updatedFilterValuesName =
          Map<String, String>.from(state.filterValuesName)
            ..removeWhere((key, value) => value == valueToRemove.value);

      // Cập nhật filteredCategories
      final updatedFilteredCategories =
          Map<AtributesCategoryResponse, AtributesValue>.from(
              state.filteredCategories!);
      updatedFilteredCategories
          .removeWhere((category, value) => value.value == valueToRemove.value);

      // Cập nhật atributesCategoryDataSave
      final updatedAtributesCategoryDataSave =
          state.atributesCategoryDataSave.map((category) {
        final updatedValues = category.values?.map((value) {
              if (value.value == valueToRemove.value) {
                return value.copyWith(isFilter: false);
              }
              return value;
            }).toList() ??
            [];
        return category.copyWith(values: updatedValues);
      }).toList();

      emit(state.copyWith(
        filterValues: updatedFilterValues,
        filterValuesName: updatedFilterValuesName,
        filteredCategories: updatedFilteredCategories,
        atributesCategoryDataSave: updatedAtributesCategoryDataSave,
        checkFilterProductList: !state.checkFilterProductList,
      ));
    }

    await onFetch(page: startPage);
    // emit(state.copyWith(checkFilterProductList: !state.checkFilterProductList));
  }
}
