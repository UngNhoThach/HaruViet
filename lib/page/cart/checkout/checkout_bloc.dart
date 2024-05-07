import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/page/cart/checkout/widgets/checkout_params.dart';

import 'checkout_state.dart';

class CheckOutBloc extends BaseBloc<CheckOutState> {
  CheckOutBloc() : super(const CheckOutState());
  getData(CheckoutParams params) async {
    emit(state.copyWith(
      isLoading: true,
    ));

    emit(state.copyWith(
      isLoading: false,
    ));
  }
}
