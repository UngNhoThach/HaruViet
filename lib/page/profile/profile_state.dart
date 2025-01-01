import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/data_local/user_state.dart';
import 'package:haruviet/data/reponsitory/cart_orders/models/cart_order_status_response/data_status_order.dart';

part 'profile_state.g.dart';

@CopyWith()
class ProfileState extends BaseState {
  final bool isSubmitSuccess;
  final UserState? userInfoLogin;
  final bool isLoginSuccess;
  final List<DataStatusOrder> listStatusOrder;

  final int indexShippingMethod;
  final bool isLoading;
  const ProfileState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.isSubmitSuccess = false,
    this.isLoading = false,
    this.indexShippingMethod = 0,
    this.listStatusOrder = const [],
    this.isLoginSuccess = false,
    this.userInfoLogin,
  }) : super(viewState, errorMsg);
}
