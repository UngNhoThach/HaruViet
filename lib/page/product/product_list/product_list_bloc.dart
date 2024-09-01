import 'package:haruviet/api/services/products/models/get_list_product_request.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/component/status/status_header_item.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/data/reponsitory/product/product_repository.dart';
import 'package:haruviet/database_local/suggestion_data_search/suggestion_data_search_database.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/page/product/product_list/product_list_state.dart';
import 'package:flutter/foundation.dart';
import 'package:haruviet/page/product/product_list/widgets/product_list_page_params.dart';

// ProductListBloc
class ProductListBloc extends BaseBloc<ProductListState> {
  final ProductListPageParams? params;
  ProductListBloc(this.params) : super(const ProductListState());
  final ProductRepository _productRepository = ProductRepository();
  final SuggestionDataSearchDatabase searchDatabase =
      SuggestionDataSearchDatabase();

  onChangeFirstTimeLoadinPage(bool firtTimeLoadingPage) {
    emit(state.copyWith(firtTimeLoadingPage: firtTimeLoadingPage));
  }

  getData() async {
    emit(state.copyWith(
      isLoading: true,
    ));
//    if (state.firtTimeLoadingPage) {
    try {
      final userInfoLogin = await Preference.getUserInfo();

      emit(state.copyWith(
        userInfoLogin: userInfoLogin,
      ));
      await onFetch(page: startPage);
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      emit(state.copyWith(
          viewState: ViewState.error, errorMsg: error.toString()));
    } finally {
      emit(state.copyWith(
        isLoading: false,
      ));
    }
    //}
  }

  onReset() {
    onFetch(page: startPage);
  }

  bool isINT(double number) {
    return number % 1 == 0;
  }

  bool canLoadMore = false;

  onFetch({
    required int page,
  }) async {
    // emit(state.copyWith(
    //   isLoading: true,
    // ));
    try {
      // Reset the list if fetching the first page
      //  List<DataProduct> updatedDataList = [];
      if (page == startPage) {
        emit(
          state.copyWith(
            newDataList: null,
            canLoadMore: false,
            //     datatList: updatedDataList, // Reset datatList to an empty list
          ),
        );
      }
      //else {
      // Keep the existing list if not fetching the first page
      //   updatedDataList = List<DataProduct>.from(state.datatList);
      // }

      final productList = await _productRepository.getListProductsRP(
        request: GetListProductRequest(
            paegNumber: page,
            pageSize: state.limit,
            category: params?.subCategoryID ?? '',
            sort: state.currentTab.value),
      );

      //   updatedDataList.addAll(productList.data ?? []);

      var newDataList = List<DataProduct>.from(productList.data ?? []);

      final maxLoadMore = ((productList.total ?? 0) / state.limit).floor();
      // final canLoadMore = page < maxLoadMore;

      if (isINT(((productList.total ?? 0) / state.limit))) {
        canLoadMore = page < maxLoadMore;
      } else {
        canLoadMore = page <= maxLoadMore;
        print('error');
      }

      emit(state.copyWith(
        //     datatList: updatedDataList,
        newDataList: newDataList,
        currentPage: page,
        canLoadMore: canLoadMore,
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
    // emit(state.copyWith(
    //   isLoading: false,
    // ));
  }

  // onchange current tab
  onChangeCurrentTab(CurrentTab currentTab) {
    emit(state.copyWith(currentTab: currentTab));
  }
}
