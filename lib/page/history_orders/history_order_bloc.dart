import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/cart_orders/cart_order_repository.dart';
import 'history_order_state.dart';

class HistoryOrderBloc extends Cubit<HistoryOrderState> {
  HistoryOrderBloc() : super(const HistoryOrderState());
  final CartOrderRepository _cartOrderRepository = CartOrderRepository();

  getData() async {
    emit(state.copyWith(
      isLoading: true,
    ));
    try {
      final data = await Preference.getUserInfo();
      final status = await _cartOrderRepository.getStatusOrderRP();
      emit(
          state.copyWith(listStatusOrder: status.data, idUser: data?.id ?? ''));
    } catch (e) {
      print(e);
    }
    emit(state.copyWith(
      isLoading: false,
    ));
  }

  onReload() {}

  onChangeTab(int tab) {
    emit(state.copyWith(
      tab: tab,
    ));
  }
}
