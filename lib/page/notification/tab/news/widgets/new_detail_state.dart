import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/data_local/user_state.dart';

part 'new_detail_state.g.dart';

@CopyWith()
class NewDetailState extends BaseState {
  final bool isSubmitSuccess;
  final UserState? userInfoLogin;
  final bool isLoading;
  const NewDetailState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.isSubmitSuccess = false,
    this.isLoading = false,
    this.userInfoLogin,
  }) : super(viewState, errorMsg);
}
