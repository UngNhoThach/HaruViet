import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
part 'review_state.g.dart';

@CopyWith()
class ReviewState extends BaseState {
  final bool isLoading;

  const ReviewState({
    ViewState viewState = ViewState.loaded,
    String errorMsg = '',
    this.isLoading = false,
  }) : super(viewState, errorMsg);
}
