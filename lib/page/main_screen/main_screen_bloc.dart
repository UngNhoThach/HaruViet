import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/database_local/product/cart_database.dart';
import 'package:haruviet/page/main_screen/main_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreenBloc extends Cubit<MainScreenState> {
  MainScreenBloc() : super(const MainScreenState());
  getData() async {
    final data = await Preference.getUserInfo();
    int totalItemInCart = await CartDatabase.instance.getCount();

    emit(state.copyWith(
      fullName: data?.name,
      dataUser: data,
      totalItemInCart: totalItemInCart,
      accessToken: data?.accessToken,
    ));
  }
}
