import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haruviet/data/reponsitory/cart_orders/cart_order_repository.dart';

import 'drawer_list_state.dart';

class DrawerListBloc extends Cubit<DrawerListState> {
  DrawerListBloc() : super(const DrawerListState());
  final CartOrderRepository _cartOrderRepository = CartOrderRepository();

  getData() async {
    emit(state.copyWith(viewState: ViewState.loading, isLoading: true));
    try {
      final data = await Preference.getUserInfo();
      final order = await _cartOrderRepository.getStatusOrderRP();
      emit(state.copyWith(
          dataUser: data,
          listStatusOrder: order.parseDataStatusOrder(),
          viewState: ViewState.loaded));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }

      emit(state.copyWith(
          viewState: ViewState.error, errorMsg: error.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
