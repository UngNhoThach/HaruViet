import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/page/cart/payment_method/widgets/payment_method_params.dart';

import 'payment_method_state.dart';

class PaymentMethodBloc extends BaseBloc<PaymentMethodState> {
  PaymentMethodBloc() : super(const PaymentMethodState());
  getData({
    required PaymentMethodParams params,
  }) async {
    emit(state.copyWith(
      isLoading: true,
    ));

    if (params.dataPayment == null) {
    } else {
      int indexShippingMethod = params.dataPayment!
          .indexWhere((element) => element.key == params.keyPaymentMethod);
      emit(state.copyWith(
        valueShipping: params.valueShipping,
        keyPaymentMethod: params.keyPaymentMethod,
        dataPayment: params.dataPayment,
        indexShippingMethod: indexShippingMethod,
      ));
    }
    emit(state.copyWith(
      isLoading: false,
    ));
  }

  onChangeShippingMethod(
      {required int indexShippingMethod,
      required String valueShipping,
      required String keyPaymentMethod}) {
    emit(state.copyWith(
        keyPaymentMethod: keyPaymentMethod,
        indexShippingMethod: indexShippingMethod,
        valueShipping: valueShipping));
  }
}
