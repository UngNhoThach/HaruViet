import 'package:eco_app/data/local/user_preferences.dart';
import 'package:eco_app/page/main_screen/main_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreenBloc extends Cubit<MainScreenState> {
  MainScreenBloc() : super(const MainScreenState());
  getData() async {
    final data = await Preference.getUserInfo();
    emit(state.copyWith(
      fullName: data?.name,
      dataUser: data,
      accessToken: data?.accessToken,
    ));
  }
}
