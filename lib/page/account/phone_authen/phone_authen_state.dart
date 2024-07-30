import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/customers/models/register_response/data_register.dart';
import 'package:haruviet/data/data_local/user_state.dart';
import 'package:haruviet/helper/base_status_response.dart';
import 'package:haruviet/page/account/signup/widgets/verify_status.dart';

part 'phone_authen_state.g.dart';

@CopyWith()
class PhoneAuthState extends BaseState {
  final BaseStatusResponse baseStatusResponse;
  final VerifyStatus verifyStatus;

  final String? nameGetOTP;
  final String? emailChange;
  final String? passwordChange;
  final String? rePasswordChange;
  final String? userNameChange;
  final String? message;
  final int? codeVerification;
  final int? timeout;
  final bool isTimeUp;
  final bool isSubmitSuccess;
  final bool isSubmitSuccessUpdate;
  final DataRegister? dataRegister;

  final bool isLoading;
  final UserInfoLogin? dataUser;

  const PhoneAuthState({
    ViewState viewState = ViewState.loaded,
    this.dataRegister,
    this.baseStatusResponse = BaseStatusResponse.initial,
    this.verifyStatus = VerifyStatus.initial,
    String errorMsg = '',
    this.timeout,
    this.message,
    this.nameGetOTP,
    this.isSubmitSuccess = false,
    this.isSubmitSuccessUpdate = false,
    this.isTimeUp = false,
    this.codeVerification,
    this.emailChange,
    this.userNameChange,
    this.passwordChange,
    this.rePasswordChange,
    this.isLoading = false,
    this.dataUser,
  }) : super(viewState, errorMsg);

  bool get isValidPassWord {
    return rePasswordChange == passwordChange;
  }
}
