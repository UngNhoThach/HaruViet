import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/enum.dart';
import 'package:eco_app/data/reponsitory/customers/models/login_response/data_login.dart';
import 'package:eco_app/data/data_local/user_state.dart';
import 'package:eco_app/page/account/signup/widgets/sigup_status.dart';
import 'package:eco_app/page/account/signup/widgets/verify_status.dart';

part 'signin_state.g.dart';

@CopyWith()
class SignInState extends BaseState {
  final bool? isLoadingButton;
  final VerifyStatus? verifyStatus;

  final SigupStatus? sigupStatus;
  final bool isSubmitSuccess;
  final String? email;
  final String? password;
  final bool isLoading;
  final String? accessToken;
  final UserInfoLogin? dataUser;
  final DataLogin? dataLogin;
  final String? message;
  const SignInState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.sigupStatus = SigupStatus.initial,
    this.email,
    this.accessToken,
    this.password,
    this.isLoadingButton,
    this.verifyStatus = VerifyStatus.initial,
    this.isLoading = false,
    this.dataLogin,
    this.isSubmitSuccess = false,
    this.dataUser,
    this.message,
  }) : super(viewState, errorMsg);

  // bool get isValidPassWord {
  //   return rePasswordChange == passwordChange;
  // }
}
