import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/product/models/list_product/data_product/data_product.dart';
import 'package:haruviet/data/reponsitory/product/product_repository.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/page/product/product_list/product_list_state.dart';
import 'package:flutter/foundation.dart';

// ProductListBloc
class ProductListBloc extends BaseBloc<ProductListState> {
  ProductListBloc() : super(const ProductListState());
  final ProductRepository _productRepository = ProductRepository();
  getData() async {
    emit(state.copyWith(
      isLoading: true,
    ));
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
    emit(state.copyWith(
      isLoading: false,
    ));
    onFetch(page: startPage);
  }

  onReset() {
    onFetch(page: startPage);
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

  // onFetch({
  //   required int page,
  // }) async {
  //   try {
  //     emit(state.copyWith(
  //       isLoading: true,
  //     ));
  //     if (page == startPage) {
  //       emit(
  //         state.copyWith(
  //           newDataList: null,
  //           canLoadMore: false,
  //         ),
  //       );
  //     }
  //     final productList = await _productRepository.getListProductsRP(
  //         size: state.limit.toString(), totalproduct: page.toString());

  //     final datatList = List<DataProduct>.from(state.datatList)
  //       ..addAll(productList.data ?? []);

  //     final maxLoadMore = ((productList.total ?? 0) / state.limit).floor();
  //     final canLoadMore = page <= maxLoadMore;

  //     emit(state.copyWith(
  //       productList: productList,
  //       datatList: datatList,
  //       newDataList: productList.data,
  //       currentPage: page,
  //       canLoadMore: canLoadMore,
  //     ));

  //     emit(state.copyWith(
  //       isLoading: false,
  //     ));
  //   } catch (error, statckTrace) {
  //     if (kDebugMode) {
  //       print("$error + $statckTrace");
  //     }
  //     emit(state.copyWith(
  //         viewState: ViewState.error, errorMsg: error.toString()));
  //   }
  // }
}
