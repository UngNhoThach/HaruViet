import 'package:eco_app/data/enum.dart';
import 'package:eco_app/data/local/user_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'drawer_list_state.dart';

class DrawerListBloc extends Cubit<DrawerListState> {
  DrawerListBloc() : super(const DrawerListState());

  getData() async {
    emit(state.copyWith(viewState: ViewState.loading, isLoading: true));
    try {
      final data = await Preference.getUserInfo();
      emit(state.copyWith(dataUser: data, viewState: ViewState.loaded));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }

      emit(state.copyWith(
          viewState: ViewState.error, errorMsg: error.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
