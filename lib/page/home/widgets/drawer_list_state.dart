import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/enum.dart';
import 'package:eco_app/data/data_local/user_state.dart';
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
