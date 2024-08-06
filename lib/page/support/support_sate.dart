import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
part 'support_sate.g.dart';

@CopyWith()
class SupportState extends BaseState {
  final bool isLoading;

  const SupportState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.isLoading = false,
  }) : super(viewState, errorMsg);
}
