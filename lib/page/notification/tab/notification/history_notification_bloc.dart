import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/enum.dart';
import 'package:eco_app/data/local/user_preferences.dart';
import 'package:eco_app/page/notification/tab/notification/history_notification_state.dart';
import 'package:eco_app/service/clearedStoredData.dart';
import 'package:flutter/foundation.dart';

// HistoryNotificationBloc
class HistoryNotificationBloc extends BaseBloc<HistoryNotificationState> {
  HistoryNotificationBloc() : super(const HistoryNotificationState());

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
