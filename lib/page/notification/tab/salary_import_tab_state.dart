import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/enum.dart';
import 'package:eco_app/data/reponsitory/news/news_response.dart';
import 'package:eco_app/data/data_local/user_state.dart';

@CopyWith()
class NotificationTabState extends BaseState {
  final bool isSubmitSuccess;
  final UserInfoLogin? userInfoLogin;
  final List<NewsResponse>? listNews;
  final bool isLoading;
  const NotificationTabState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.isSubmitSuccess = false,
    this.listNews,
    this.isLoading = false,
    this.userInfoLogin,
  }) : super(viewState, errorMsg);
}
