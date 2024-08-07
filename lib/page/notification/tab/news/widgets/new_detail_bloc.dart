import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/customers/customers_repository.dart';
import 'package:haruviet/page/notification/tab/news/widgets/new_detail_state.dart';
import 'package:haruviet/service/clearedStoredData.dart';
import 'package:flutter/foundation.dart';

// NewDetailBloc
class NewDetailBloc extends BaseBloc<NewDetailState> {
  NewDetailBloc() : super(const NewDetailState());
  final CustomersRepository _customersRepository = CustomersRepository();

  getData() async {
    emit(state.copyWith(
      isLoading: true,
    ));
    try {
      final userInfoLogin = await Preference.getUserInfo();

      emit(state.copyWith(userInfoLogin: userInfoLogin));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      emit(state.copyWith(
          viewState: ViewState.error, errorMsg: error.toString()));
    }
    emit(state.copyWith(
      isLoading: false,
    ));
  }

  onLogout() async {
    emit(state.copyWith(
      isLoading: true,
    ));
    // emit(state.copyWith(isSubmitSuccess: false));
    await clearSharedPreferencesData();
    await getData();
    emit(state.copyWith(
      isLoading: false,
    ));
  }
}
