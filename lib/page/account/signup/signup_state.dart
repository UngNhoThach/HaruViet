import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/reponsitory/customers/models/login_response/data_login.dart';
import 'package:haruviet/data/reponsitory/customers/models/login_response/login_response.dart';
import 'package:haruviet/data/reponsitory/normal_response/normal_error.dart';
import 'package:haruviet/data/data_local/user_state.dart';
import 'package:haruviet/page/account/signup/widgets/sigup_type.dart';

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
}
