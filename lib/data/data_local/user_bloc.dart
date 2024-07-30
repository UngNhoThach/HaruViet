import 'dart:developer';

import 'package:haruviet/api/rest_client.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/data_local/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Cubit<UserInfoLogin> {
  UserBloc() : super(UserInfoLogin());

  loadData() async {
    try {
      final userInfoLogin = await Preference.getUserInfo();
      if (userInfoLogin != null) {
        emit(userInfoLogin);
        RestClient().init(userInfoLogin.subDomain ?? "");
      }
    } catch (error, stackTrace) {
      log("$error $stackTrace");
    }
  }

  UserInfoLogin get user => state;

  onLogin(UserInfoLogin user) {
    emit(user.copyWith(subDomain: state.subDomain));
    Preference.setUserInfo(user);
    RestClient().init(user.subDomain ?? "");
  }

  onUpdateUserInfoLogin(UserInfoLogin userInfoLogin) {
    emit(userInfoLogin);
  }

  onUpdateSubDomain(String subDomain) {
    emit(state.copyWith(subDomain: subDomain));
    Preference.setUserInfo(state);
  }
}
