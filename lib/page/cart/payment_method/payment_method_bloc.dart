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
    List<String> methodNames = [
      'Thanh toán khi nhận hàng (COD)',
      'Thẻ ATM nội địa/Internet Banking (Hỗ trợ Internet Banking)',
      'Thanh toán bằng Momo',
    ];

    emit(state.copyWith(
      methodNames: methodNames,
      indexShippingMethod: params.indexShippingMethod,
      valueShipping: methodNames[params.indexShippingMethod!],
    ));
    emit(state.copyWith(
      isLoading: false,
    ));
  }

  onChangeShippingMethod(
      {required int indexShippingMethod, required String valueShipping}) {
    emit(state.copyWith(
        indexShippingMethod: indexShippingMethod,
        valueShipping: valueShipping));
  }
}
