import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/shipment/payment_response/data_payment.dart';
part 'payment_method_state.g.dart';

@CopyWith()
class PaymentMethodState extends BaseState {
  final bool isLoading;
  final int indexShippingMethod;
  final List<DataPayment>? dataPayment;
  final String? valueShipping;
  final String? keyPaymentMethod;

  const PaymentMethodState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.keyPaymentMethod,
    this.indexShippingMethod = 0,
    this.isLoading = false,
    this.dataPayment = const [],
    this.valueShipping,
  }) : super(viewState, errorMsg);
}
