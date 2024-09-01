import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/page/review/review_state.dart';

class ReviewBloc extends BaseBloc<ReviewState> {
  ReviewBloc() : super(const ReviewState());
  getData() async {
    emit(state.copyWith(
      isLoading: true,
    ));

    emit(state.copyWith(
      isLoading: false,
    ));
  }
}
