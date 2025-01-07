import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/cart_orders/cart_order_repository.dart';
import 'package:haruviet/helper/const.dart';
import 'package:haruviet/page/history_orders/tab/widgets/order_detail_params.dart';

import 'order_detail_state.dart';

class OrderDetailBloc extends Cubit<OrderDetailState> {
  final OrderDetailParams params;

  final CartOrderRepository _cartOrderRepository = CartOrderRepository();

  //
  OrderDetailBloc({required this.params}) : super(const OrderDetailState());

  getData() async {
    final data = await Preference.getUserInfo();
    emit(state.copyWith(idUser: data?.id ?? ''));
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
      final orders = await _cartOrderRepository.getOderDetailRP(
          idCustomer: state.idUser ?? '', idOrder: params.idOrder);
      emit(state.copyWith(
        newDataList: orders.details ?? [],
      ));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      emit(state.copyWith(
          viewState: ViewState.error, errorMsg: error.toString()));
    }
  }

  // onGetDetailProduct({
  //   required String idProduct,
  // }) async {
  //   emit(state.copyWith(
  //     isLoadingProductDetails: true,
  //   ));
  //   try {
  //     final orderDetail =
  //         await _productRepository.getProductDetailsRP(idProduct: idProduct);
  //     emit(state.copyWith(
  //       orderDetail: orderDetail,
  //     ));
  //   } catch (e) {
  //     print(e);
  //   } finally {
  //     emit(state.copyWith(
  //       isLoadingProductDetails: false,
  //     ));
  //   }
  // }
}
