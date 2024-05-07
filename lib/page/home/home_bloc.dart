import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/enum.dart';
import 'package:eco_app/data/local/user_preferences.dart';
import 'package:eco_app/data/reponsitory/customers/customers_repository.dart';
import 'package:eco_app/page/profile/profile_state.dart';
import 'package:eco_app/service/clearedStoredData.dart';
import 'package:flutter/foundation.dart';

// ProfileBloc
class ProfileBloc extends BaseBloc<ProfileState> {
  ProfileBloc() : super(const ProfileState());
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
