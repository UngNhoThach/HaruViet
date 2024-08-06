import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/product/models/data_search_default_response/search_category.dart';
import 'package:haruviet/data/reponsitory/product/models/data_search_default_response/search_product.dart';
import 'package:haruviet/data/reponsitory/product/product_repository.dart';
import 'package:haruviet/database_local/suggestion_data_search/models/suggestion_data_search_model.dart';
import 'package:haruviet/database_local/suggestion_data_search/suggestion_data_search_database.dart';
import 'package:haruviet/page/product/search/search_product_category_state.dart';

class SearchProductCategoryBloc extends BaseBloc<SearchProductCategoryState> {
  SearchProductCategoryBloc() : super(const SearchProductCategoryState());
  final ProductRepository _productRepository = ProductRepository();
  final SuggestionDataSearchDatabase searchDatabase =
      SuggestionDataSearchDatabase();

  getData() async {
    final List<SuggestionDataSearchModel> searchDataList;

    searchDataList = await searchDatabase.getAllDataSearch();

    emit(state.copyWith(searchDataList: searchDataList));
  }

  searchData(String keyword, int lengthKeyword) async {
    final check = countStringKeyword(lengthKeyword);
    final value = isInteger(check);
    // Clear previous debounce timer if still active
    // Set a new debounce timer
    if (lengthKeyword >= 3 && value == true) {
      await onGetDataSearch(keyword);
      onSaveDataSearchLocal(keyword);
      // inSertDataSearch(value: keyword);
    } else if (!hasTrailingSpace(keyword) &&
        keyword != '' &&
        keyword.length >= 3 &&
        value == false) {
      searchDataDounce(keyword);
    }
  }

  Future<void> onKeywordChanged({
    required String keyword,
  }) async {
    final lengthKeyword = keyword.length;
    if (keyword == '' || lengthKeyword < 3) {
      await onResetSearch();
    } else if (lengthKeyword <= 6) {
      searchData(keyword, lengthKeyword);
    } else {
      searchDataDounce(keyword);
    }
  }

  onReturnDataList() {
    return state.searchDataList;
  }

  onResetSearch() {
    emit(state.copyWith(
      productSearchList: [],
      categorySearchList: [],
    ));
  }

  searchDataDounce(String keyword) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    } else {
      _debounce = Timer(const Duration(milliseconds: 400), () {
        onGetDataSearch(keyword);
        onSaveDataSearchLocal(keyword);
        //  inSertDataSearch(value: keyword);
      });
    }
  }

  bool hasTrailingSpace(String keyword) {
    return keyword.endsWith(' ');
  }

  Future<void> onGetDataSearch(String keyword) async {
    try {
      final searchList =
          await _productRepository.searchDefaultRP(keyword: keyword);
      List<SearchProduct> productSearchList =
          (searchList.products ?? []).take(5).toList();
      List<SearchCategory> categorySearchList =
          (searchList.categories ?? []).take(5).toList();

      emit(state.copyWith(
          productSearchList: productSearchList,
          categorySearchList: categorySearchList));
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print("$error + $stackTrace");
      }
      emit(state.copyWith(
        viewState: ViewState.error,
        errorMsg: error.toString(),
      ));
    }
  }

  // Debounce Timer
  Timer? _debounce;

  // check length of keywords string
  double countStringKeyword(int length) {
    final value = length / 3;
    return value;
  }

  // check is integer number
  bool isInteger(num value) => (value % 1) == 0;

  void onSaveDataSearchLocal(String value) {
    List<SuggestionDataSearchModel> searchDataList =
        List.from(state.searchDataList);

    if (hasTrailingSpace(value)) {
      String valueTrim = value.substring(0, value.length - 1);
      onInsertDataSearchLocal(searchDataList: searchDataList, value: valueTrim);
    } else {
      onInsertDataSearchLocal(searchDataList: searchDataList, value: value);
    }
    if (searchDataList.length > 15) {
      searchDataList.removeAt(0); // delete the last item
    }

    // Cập nhật lại state
    emit(state.copyWith(searchDataList: searchDataList));
  }

  onInsertDataSearchLocal(
      {required List<SuggestionDataSearchModel> searchDataList,
      required String value}) {
    // remove item ==
    searchDataList.removeWhere((item) => item.value == value);

    //  add new item
    final time = DateTime.now().millisecondsSinceEpoch;
    searchDataList.add(SuggestionDataSearchModel(
      value: value,
      dateLastview: time,
    ));
    onInsertSearchDataToDatabase(
        SuggestionDataSearchModel(value: value, dateLastview: time));
  }

  onInsertSearchDataToDatabase(SuggestionDataSearchModel value) async {
    await searchDatabase.insertDataSearch(value);
  }
}
