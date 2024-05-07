import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/enum.dart';
import 'package:eco_app/data/user/user_state.dart';

part 'new_detail_state.g.dart';

@CopyWith()
class NewDetailState extends BaseState {
  final bool isSubmitSuccess;
  final UserInfoLogin? userInfoLogin;
  final bool isLoading;
  const NewDetailState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.isSubmitSuccess = false,
    this.isLoading = false,
    this.userInfoLogin,
  }) : super(viewState, errorMsg);
}
