import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/enum.dart';
import 'package:eco_app/data/reponsitory/normal_response/normal_error.dart';
import 'package:eco_app/helper/base_status_response.dart';
import 'package:eco_app/page/account/signup/widgets/verify_status.dart';

part 'reset_password_state.g.dart';

@CopyWith()
class ResetPassWordState extends BaseState {
  final BaseStatusResponse baseStatusResponse;
  final bool isSubmitSuccessUpdate;

  final bool isSubmitSuccess;
  final String? password;
  final String? rePassword;
  final VerifyStatus verifyStatus;
  final String? message;
  final int? timeout;
  final NormalError? errors;
  final bool isTimeUp;
  final String? nameGetOTP;
  final int? codeVerification;

  final bool isLoading;
  const ResetPassWordState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.baseStatusResponse = BaseStatusResponse.initial,
    this.isSubmitSuccessUpdate = false,
    this.isTimeUp = false,
    this.nameGetOTP,
    this.codeVerification,
    this.rePassword,
    this.verifyStatus = VerifyStatus.initial,
    this.password,
    this.errors,
    this.timeout,
    this.message,
    this.isSubmitSuccess = false,
    this.isLoading = false,
  }) : super(viewState, errorMsg);
}
