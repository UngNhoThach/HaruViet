import 'package:flutter/widgets.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/cart_orders/cart_order_repository.dart';
import 'package:haruviet/database_local/product/cart_provider_v2.dart';
import 'package:haruviet/page/profile/profile_state.dart';
import 'package:haruviet/service/clearedStoredData.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

// ProfileBloc
class ProfileBloc extends BaseBloc<ProfileState> {
  final BuildContext context;

  ProfileBloc(this.context) : super(const ProfileState());
  final CartOrderRepository _cartOrderRepository = CartOrderRepository();

  getData() async {
    emit(state.copyWith(
      isLoading: true,
    ));
    try {
      final userInfoLogin = await Preference.getUserInfo();
      final paymentData = await Preference.getPayment();
      final order = await _cartOrderRepository.getStatusOrderRP();

      emit(state.copyWith(
        listStatusOrder: order.parseDataStatusOrder(),
        userInfoLogin: userInfoLogin,
        isLoginSuccess: userInfoLogin != null ? userInfoLogin.isLogin : false,
        indexShippingMethod:
            paymentData != null ? paymentData.indexShippingMethod : 0,
      ));
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
    final cart = Provider.of<CartProviderV2>(context, listen: false);

    emit(state.copyWith(
      isLoading: true,
    ));
    await clearSharedPreferencesData();
    cart.setPrefsItemsLogout();
    await getData();
    emit(state.copyWith(
      isLoading: false,
    ));
  }
}
