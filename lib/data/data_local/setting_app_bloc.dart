import 'dart:developer';

import 'package:haruviet/api/rest_clien_ghtk.dart';
import 'package:haruviet/api/rest_client.dart';
import 'package:haruviet/data/data_local/setting_app_state.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingAppBloc extends Cubit<SettingAppState> {
  SettingAppBloc() : super(SettingAppState());
  loadData() async {
    try {
      final appconfig = await Preference.getAppConfig();
      final userInfo = await Preference.getUserInfo();

      if (appconfig != null) {
        emit(appconfig);
        RestClient().init(appconfig.xUrl ?? "",
            accessToken: appconfig.xApiKey,
            authorization: userInfo?.accessToken);
        RestClientGHTK().init(
          "https://services.giaohangtietkiem.vn",
        );
      }
    } catch (error, stackTrace) {
      log("$error $stackTrace");
    }
  }

  // SettingAppState get user => state;

  // onUpdateState(SettingAppState settingAppState) {
  //   emit(settingAppState.copyWith(xUrl: state.xUrl));
  // }
}
