import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/cart_orders/models/cart_order_status_response/data_status_order.dart';

part 'history_order_state.g.dart';

@CopyWith()
class HistoryOrderState extends BaseState {
  final List<DataStatusOrder>? listStatusOrder;
  final String? idUser;
  final bool isLoading;
  final int tab;

  const HistoryOrderState({
    ViewState viewState = ViewState.initial,
    String errorMsg = '',
    this.listStatusOrder = const [],
    this.idUser,
    this.isLoading = false,
    this.tab = 1,
  }) : super(viewState, errorMsg);
}
