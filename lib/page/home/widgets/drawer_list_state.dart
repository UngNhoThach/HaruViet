import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/data_local/user_state.dart';
part 'drawer_list_state.g.dart';

@CopyWith()
class DrawerListState extends BaseState {
  final bool isLoading;
  final UserInfoLogin? dataUser;

  const DrawerListState({
    ViewState viewState = ViewState.initial,
    String errorMsg = '',
    this.dataUser,
    this.isLoading = false,
  }) : super(viewState, errorMsg);
}
