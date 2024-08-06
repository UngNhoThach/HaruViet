import 'dart:async';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/component/status/status_header_item.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/data/reponsitory/product/models/data_search_default_response/search_category.dart';
import 'package:haruviet/data/reponsitory/product/models/data_search_default_response/search_product.dart';
import 'package:haruviet/data/reponsitory/product/product_repository.dart';
import 'package:haruviet/database_local/suggestion_data_search/models/suggestion_data_search_model.dart';
import 'package:haruviet/database_local/suggestion_data_search/suggestion_data_search_database.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/page/product/product_list/product_list_state.dart';
import 'package:flutter/foundation.dart';

// ProductListBloc
class ProductListBloc extends BaseBloc<ProductListState> {
  ProductListBloc() : super(const ProductListState());
  final ProductRepository _productRepository = ProductRepository();
  final SuggestionDataSearchDatabase searchDatabase =
      SuggestionDataSearchDatabase();
  onChangeSearch() {
    emit(state.copyWith(checkSearch: state.checkSearch));
  }

  onChangeFirstTimeLoadinPage(bool firtTimeLoadingPage) {
    emit(state.copyWith(firtTimeLoadingPage: firtTimeLoadingPage));
  }

  onInsertSearchDataToDatabase(SuggestionDataSearchModel value) async {
    await searchDatabase.insertDataSearch(value);
  }

  getData() async {
    emit(state.copyWith(
      isLoading: true,
    ));
    if (state.firtTimeLoadingPage) {
      try {
        final userInfoLogin = await Preference.getUserInfo();

        emit(state.copyWith(
          userInfoLogin: userInfoLogin,
        ));
      } catch (error, statckTrace) {
        if (kDebugMode) {
          print("$error + $statckTrace");
        }
        emit(state.copyWith(
            viewState: ViewState.error, errorMsg: error.toString()));
      }
    }
    emit(state.copyWith(
      isLoading: false,
    ));
    onFetch(page: startPage);
  }

  onReset() {
    onFetch(page: startPage);
  }

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

  onFetch({
    required int page,
  }) async {
    try {
      emit(state.copyWith(
        isLoading: true,
      ));

      // Reset the list if fetching the first page
      List<DataProduct> updatedDataList = [];
      if (page == startPage) {
        emit(
          state.copyWith(
            newDataList: null,
            canLoadMore: false,
            datatList: updatedDataList, // Reset datatList to an empty list
          ),
        );
      } else {
        // Keep the existing list if not fetching the first page
        updatedDataList = List<DataProduct>.from(state.datatList);
      }

      final productList = await _productRepository.getListProductsRP(
          size: state.limit.toString(), totalproduct: page.toString());

      updatedDataList.addAll(productList.data ?? []);

      final maxLoadMore = ((productList.total ?? 0) / state.limit).floor();
      final canLoadMore = page <= maxLoadMore;

      emit(state.copyWith(
        productList: productList,
        datatList: updatedDataList,
        newDataList: productList.data,
        currentPage: page,
        canLoadMore: canLoadMore,
      ));

      emit(state.copyWith(
        isLoading: false,
      ));
      onChangeFirstTimeLoadinPage(false);
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

  // Method to handle keyword search
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

  bool hasTrailingSpace(String keyword) {
    return keyword.endsWith(' ');
  }

  searchDataDounce(String keyword) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    } else {
      _debounce = Timer(const Duration(milliseconds: 500), () {
        onGetDataSearch(keyword);
        onSaveDataSearchLocal(keyword);
        //  inSertDataSearch(value: keyword);
      });
    }
  }

  readDataSearch() async {
    final List<SuggestionDataSearchModel> searchDataList;

    searchDataList = await searchDatabase.getAllDataSearch();
    emit(state.copyWith(
      searchDataList: searchDataList,
    ));
  }

  onResetSearch() {
    emit(state.copyWith(
      productSearchList: [],
      categorySearchList: [],
    ));
  }

  // Cancel debounce timer if it's still active
  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }

  // onchange current tab
  onChangeCurrentTab(CurrentTab currentTab) {
    emit(state.copyWith(currentTab: currentTab));
    getData();
  }
}
