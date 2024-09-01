import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/data_local/user_state.dart';
import 'package:haruviet/data/reponsitory/cart_orders/models/cart_order_status_response/data_status_order.dart';
part 'drawer_list_state.g.dart';

@CopyWith()
class DrawerListState extends BaseState {
  final bool isLoading;
  final List<DataStatusOrder> listStatusOrder;

  final UserInfoLogin? dataUser;

  const DrawerListState({
    ViewState viewState = ViewState.initial,
    String errorMsg = '',
    this.listStatusOrder = const [],
    this.dataUser,
    this.isLoading = false,
  }) : super(viewState, errorMsg);
}
