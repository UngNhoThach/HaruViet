import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/normal_response/normal_error.dart';
import 'package:haruviet/page/account/signup/widgets/sigup_type.dart';
import 'package:haruviet/page/account/signup/widgets/verify_status.dart';

part 'forget_password_state.g.dart';

@CopyWith()
class ForgetPassWordState extends BaseState {
  final bool isSubmitSuccess;
  final String? emailChange;
  final NormalError? errors;
  final SigupType? sigupType;

  final VerifyStatus? verifyStatus;
  final String? message;
  final int? timeout;
  final bool isLoading;
  const ForgetPassWordState({
    ViewState viewState = ViewState.loaded,
    this.verifyStatus = VerifyStatus.initial,
    String errorMsg = '',
    this.message,
    this.sigupType,
    this.timeout,
    this.errors,
    this.emailChange,
    this.isSubmitSuccess = false,
    this.isLoading = false,
  }) : super(viewState, errorMsg);
}
