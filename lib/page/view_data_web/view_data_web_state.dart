import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'view_data_web_state.g.dart';

@CopyWith()
class ViewDataWebState extends BaseState {
  final bool isLoading;
  final WebViewController? controller;

  const ViewDataWebState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.isLoading = false,
    this.controller,
  }) : super(viewState, errorMsg);
}
