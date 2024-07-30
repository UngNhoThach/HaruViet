import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/data_local/user_state.dart';

part 'profile_state.g.dart';

@CopyWith()
class ProfileState extends BaseState {
  final bool isSubmitSuccess;
  final UserInfoLogin? userInfoLogin;
  final bool isLoading;
  const ProfileState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.isSubmitSuccess = false,
    this.isLoading = false,
    this.userInfoLogin,
  }) : super(viewState, errorMsg);
}
