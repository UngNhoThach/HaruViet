// import 'package:eco_app/base/base_bloc.dart';
// import 'package:eco_app/data/enum.dart';
// import 'package:eco_app/data/local/user_preferences.dart';
// import 'package:eco_app/data/reponsitory/product/product_repository.dart';
// import 'package:eco_app/page/home/home_state.dart';
// import 'package:eco_app/service/clearedStoredData.dart';
// import 'package:flutter/foundation.dart';

// // HomeBloc
// class HomeBloc extends BaseBloc<HomeState> {
//   HomeBloc() : super(const HomeState());
//   // final CustomersRepository _customersRepository = CustomersRepository();
//   final ProductRepository _productRepository = ProductRepository();
//   getData() async {
//     emit(state.copyWith(
//       isLoading: true,
//     ));
//     try {
//       final userInfoLogin = await Preference.getUserInfo();
//       final productList = await _productRepository.getListProductsRP(
//           size: '3', totalproduct: '5');
//       emit(state.copyWith(
//         userInfoLogin: userInfoLogin,
//       ));
//     } catch (error, statckTrace) {
//       if (kDebugMode) {
//         print("$error + $statckTrace");
//       }
//       emit(state.copyWith(
//           viewState: ViewState.error, errorMsg: error.toString()));
//     }
//     emit(state.copyWith(
//       isLoading: false,
//     ));
//   }

//   onLogout() async {
//     emit(state.copyWith(
//       isLoading: true,
//     ));
//     // emit(state.copyWith(isSubmitSuccess: false));
//     await clearSharedPreferencesData();
//     await getData();
//     emit(state.copyWith(
//       isLoading: false,
//     ));
//   }
// }
