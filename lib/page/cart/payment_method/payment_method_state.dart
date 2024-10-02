import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
part 'payment_method_state.g.dart';

@CopyWith()
class PaymentMethodState extends BaseState {
  final bool isLoading;
  final int indexShippingMethod;
  final List<String> methodNames;
  final String? valueShipping;

  const PaymentMethodState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.indexShippingMethod = 0,
    this.isLoading = false,
    this.methodNames = const [],
    this.valueShipping,
  }) : super(viewState, errorMsg);
}
