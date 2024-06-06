import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/enum.dart';
import 'package:eco_app/data/local/user_preferences.dart';
import 'package:eco_app/data/reponsitory/product/models/list_product/data_product.dart';
import 'package:eco_app/data/reponsitory/product/product_repository.dart';
import 'package:eco_app/helper/const.dart';
import 'package:eco_app/page/home/home_state.dart';
import 'package:flutter/foundation.dart';

// HomeBloc
class HomeBloc extends BaseBloc<HomeState> {
  HomeBloc() : super(const HomeState());
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
      if (page == startPage) {
        emit(
          state.copyWith(
            newDataList: null,
            canLoadMore: false,
          ),
        );
      }
      final productList = await _productRepository.getListProductsRP(
          size: state.limit.toString(), totalproduct: page.toString());

      final datatList = List<DataProduct>.from(state.datatList)
        ..addAll(productList.data ?? []);

      final maxLoadMore = ((productList.total ?? 0) / state.limit).floor();
      final canLoadMore = page <= maxLoadMore;

      emit(state.copyWith(
        productList: productList,
        datatList: datatList,
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
}
