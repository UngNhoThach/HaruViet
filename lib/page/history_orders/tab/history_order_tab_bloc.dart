import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/cart_orders/cart_order_repository.dart';
import 'package:haruviet/data/reponsitory/product/product_repository.dart';
import 'package:haruviet/helper/const.dart';

import 'history_order_tab_state.dart';

class HistoryOrderTabBloc extends Cubit<HistoryOrderTabState> {
  final CartOrderRepository _cartOrderRepository = CartOrderRepository();
  final ProductRepository _productRepository = ProductRepository();

  //
  HistoryOrderTabBloc({
    required int tab,
  }) : super(HistoryOrderTabState(
          tab: tab,
        ));

  getData({
    required String idUser,
    required int status,
  }) async {
    final data = await Preference.getUserInfo();

    emit(state.copyWith(idUser: data?.id ?? '', status: status));
    onFetch(page: startPage);
  }

  onReset() {
    emit(state.copyWith(
      status: null,
    ));
    onFetch(page: startPage);
  }

  onFetch({
    required int page,
  }) async {
    try {
      final orders = await _cartOrderRepository.getHistoryOrdersRP(
        idCustomer: state.idUser ?? '',
        status: state.status ?? 1,
      );
      emit(state.copyWith(
        newDataList: orders.parseDataCart() ?? [],
      ));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      emit(state.copyWith(
          viewState: ViewState.error, errorMsg: error.toString()));
    }
  }

  onGetDetailProduct({
    required String idProduct,
  }) async {
    emit(state.copyWith(
      isLoadingProductDetails: true,
    ));
    try {
      final productDetail =
          await _productRepository.getProductDetailsRP(idProduct: idProduct);
      emit(state.copyWith(
        productDetail: productDetail,
      ));
    } catch (e) {
      print(e);
    } finally {
      emit(state.copyWith(
        isLoadingProductDetails: false,
      ));
    }
  }
}
