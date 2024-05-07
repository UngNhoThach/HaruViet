import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/enum.dart';

part 'checkout_state.g.dart';

@CopyWith()
class CheckOutState extends BaseState {
  final bool isLoading;

  const CheckOutState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.isLoading = false,
  }) : super(viewState, errorMsg);
}
