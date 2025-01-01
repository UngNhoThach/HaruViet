import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/database_local/suggestion_data_search/suggestion_data_search_database.dart';

import 'voucher_state.dart';

// VoucherBloc
class VoucherBloc extends BaseBloc<VoucherState> {
  VoucherBloc() : super(const VoucherState());
  final SuggestionDataSearchDatabase searchDatabase =
      SuggestionDataSearchDatabase();
  onChangeFirstTimeLoadinPage(bool firtTimeLoadingPage) {
    emit(state.copyWith());
  }

  bool canLoadMore = false;

  getData() async {
    emit(state.copyWith(
        //  isLoading: true,
        ));
  }
}
