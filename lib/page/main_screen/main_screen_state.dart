import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/data_local/user_state.dart';

part 'main_screen_state.g.dart';

@CopyWith()
class MainScreenState extends BaseState {
  final UserState? dataUser;
  final bool isLogin;
  final String employeeId;
  final String organizationId;
  final String jobPositionId;
  final String jobTitleId;
  final String? accessToken;
  final int? totalItemInCart;
  final String fullName;
  final String? noti;
  final bool isLoading;
  final bool isWorkPlanActive;
  final String? nameNavBar;
  final String? totalNotiMessage;
  final String? totalNotiNewPost;
  final bool hideBottomBar;

  const MainScreenState({
    ViewState viewState = ViewState.loaded,
    this.dataUser,
    this.isLogin = false,
    this.accessToken,
    this.totalItemInCart,
    this.hideBottomBar = false,
    String errorMsg = '',
    this.employeeId = '',
    this.fullName = '',
    this.organizationId = '',
    this.jobPositionId = '',
    this.jobTitleId = '',
    this.noti,
    this.nameNavBar,
    this.totalNotiNewPost,
    this.totalNotiMessage,
    this.isLoading = false,
    this.isWorkPlanActive = false,
  }) : super(viewState, errorMsg);
}
