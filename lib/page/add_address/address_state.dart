import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/enum.dart';

part 'address_state.g.dart';

@CopyWith()
class AddressState extends BaseState {
  final bool isLoading;
  final bool textBtnswitchState;
  final int? isLocationDefault;

  const AddressState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.isLoading = false,
    this.isLocationDefault,
    this.textBtnswitchState = false,
  }) : super(viewState, errorMsg);
}
