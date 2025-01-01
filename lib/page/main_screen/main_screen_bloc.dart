import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/database_local/product/cart_provider_v2.dart';
import 'package:haruviet/page/main_screen/main_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreenBloc extends Cubit<MainScreenState> {
  MainScreenBloc() : super(const MainScreenState());
  getData() async {
    final data = await Preference.getUserInfo();
    int totalItemInCart = (CartProviderV2().getCounter());
    final userInfoLogin = await Preference.getUserInfo();

    emit(state.copyWith(
      isLogin: userInfoLogin != null ? userInfoLogin.isLogin : false,
      fullName: data?.name,
      dataUser: data,
      totalItemInCart: totalItemInCart,
      accessToken: data?.accessToken,
    ));
  }

  onHideBottomBar() {
    emit(state.copyWith(hideBottomBar: !state.hideBottomBar));
  }
}
