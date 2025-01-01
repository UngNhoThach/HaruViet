import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';

part 'voucher_state.g.dart';

@CopyWith()
class VoucherState extends BaseState {
  const VoucherState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
  }) : super(viewState, errorMsg);
}
