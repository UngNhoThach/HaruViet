import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/enum.dart';
import 'package:eco_app/data/reponsitory/customers/models/login_response/data_login.dart';
import 'package:eco_app/data/reponsitory/customers/models/login_response/login_response.dart';
import 'package:eco_app/data/reponsitory/normal_response/normal_error.dart';
import 'package:eco_app/data/user/user_state.dart';
import 'package:eco_app/page/account/signup/widgets/sigup_type.dart';

import 'widgets/verify_status.dart';

part 'signup_state.g.dart';

@CopyWith()
class SignupState extends BaseState {
  final bool isSubmitSuccess;
  final LoginResponse? loginResponse;
  final String? accessToken;
  final VerifyStatus? verifyStatus;
  final SigupType? sigupType;
  final String? emailChange;
  final String? passwordChange;
  final String? rePasswordChange;
  final String? userNameChange;
  final String? message;
  final int? timeout;
  final bool isLoading;
  final UserInfoLogin? dataUser;
  final DataLogin? dataLogin;
  final NormalError? errors;

  const SignupState({
    ViewState viewState = ViewState.loaded,
    this.sigupType,
    this.errors,
    this.accessToken,
    this.loginResponse,
    String errorMsg = '',
    this.dataLogin,
    this.message,
    this.timeout,
    this.isSubmitSuccess = false,
    this.verifyStatus = VerifyStatus.initial,
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

  bool get isValidPassWordFormat {
    return passwordChange != null && passwordChange!.length > 5;
  }
}
