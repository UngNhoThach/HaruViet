import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/page/support/support_sate.dart';

class SupportBloc extends BaseBloc<SupportState> {
  SupportBloc() : super(const SupportState());
  getData() async {
    emit(state.copyWith(
      isLoading: true,
    ));

    emit(state.copyWith(
      isLoading: false,
    ));
  }
}
