import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/component/currency/split_currency.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/product/models/data_search_default_response/search_product.dart';
import 'package:haruviet/data/reponsitory/product/product_repository.dart';
import 'package:haruviet/database_local/suggestion_data_search/models/suggestion_data_search_model.dart';
import 'package:haruviet/database_local/suggestion_data_search/suggestion_data_search_database.dart';

import 'cart_order_voucher_state.dart';
import 'widgets/cart_order_voucher_params.dart';

class CartOrderVoucherBloc extends BaseBloc<CartOrderVoucherState> {
  CartOrderVoucherBloc() : super(const CartOrderVoucherState());

  final ProductRepository _productRepository = ProductRepository();
  final SuggestionDataSearchDatabase searchDatabase =
      SuggestionDataSearchDatabase();

  getData({required CartOrderVoucherParams params}) async {
    emit(state.copyWith(isLoading: true));

    final List<SuggestionDataSearchModel> searchDataList;

    searchDataList = await searchDatabase.getAllDataSearch();

    emit(state.copyWith(
        codeSelected: params.codeSelected,
        searchDataList: searchDataList,
        totalPrice: params.totalPrice,
        discountAmount: params.discountAmount));
    emit(state.copyWith(isLoading: false));
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
    ));
  }

  searchDataDounce(String keyword) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    } else {
      _debounce = Timer(const Duration(milliseconds: 400), () {
        onGetDataSearch(keyword);
        onSaveDataSearchLocal(keyword);
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
          (searchList.products ?? []).take(4).toList();
      emit(state.copyWith(
        productSearchList: productSearchList,
      ));
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

  onSelectedVoucher({
    required SearchProduct voucherSelected,
  }) {
    emit(state.copyWith(
        codeSelected: voucherSelected.name,
        isVoucherSelected: !state.isVoucherSelected,
        voucherSelected: voucherSelected,
        discountAmount: voucherSelected.price == null
            ? 0
            : splitLetterString(
                valueInput: voucherSelected.price!.price.toString())));
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
