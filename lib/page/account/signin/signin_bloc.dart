import 'package:flutter/widgets.dart';
import 'package:haruviet/api/rest_client.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/cart_orders/cart_order_repository.dart';
import 'package:haruviet/data/reponsitory/customers/customers_repository.dart';
import 'package:haruviet/data/data_local/user_state.dart';
import 'package:haruviet/database_local/product/cart_database_v2.dart';
import 'package:haruviet/database_local/product/cart_provider_v2.dart';
import 'package:haruviet/page/account/signin/signin_state.dart';
import 'package:haruviet/page/account/signup/widgets/sigup_status.dart';
import 'package:haruviet/page/account/signup/widgets/verify_status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class SignInBloc extends BaseBloc<SignInState> {
  final BuildContext context;

  SignInBloc(this.context) : super(const SignInState());
  final CustomersRepository _customersRepository = CustomersRepository();
  final CartOrderRepository _cartOrderRepository = CartOrderRepository();

  onChangeEmail(String? email) {
    emit(state.copyWith(
      email: email,
    ));
  }

  onChangePassword(String? password) {
    emit(state.copyWith(
      password: password,
    ));
  }
  // check is email

  bool isEmailValid(String email) {
    RegExp regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regex.hasMatch(email);
  }

  // check is phone number
  bool isValidPhone(String phone) {
    RegExp regex = RegExp(
        r'(([03+[2-9]|05+[6|8|9]|07+[0|6|7|8|9]|08+[1-9]|09+[1-4|6-9]]){3})+[0-9]{7}\b');
    return regex.hasMatch(phone);
  }

  onLoading() {
    emit(state.copyWith(
      isLoadingButton: true,
    ));
    // onSubmit();
    emit(state.copyWith(
      isLoadingButton: false,
    ));
  }

  onSubmit() async {
    emit(state.copyWith(
        sigupStatus: SigupStatus.initial,
        isSubmitSuccess: false,
        isLoading: true));
    try {
      final cart = Provider.of<CartProviderV2>(context, listen: false);

      if ((state.email ?? '').isEmpty || (state.password ?? '').isEmpty) {
        return;
      }
      var loginResponse = await _customersRepository.loginRP(
        password: state.password ?? '',
        username: state.email ?? '',
      );

      if (loginResponse.status == 200 && loginResponse.isStatus == true) {
        emit(state.copyWith(
            sigupStatus: SigupStatus.sigupSuccess,
            dataLogin: loginResponse.data,
            message: loginResponse.message ?? '',
            isSubmitSuccess: true));

        UserState dataUser = UserState(
          avatar: state.dataLogin?.user?.avatar ?? "",
          id: state.dataLogin?.user?.id ?? "",
          accessToken: state.dataLogin?.accessToken ?? "",
          tokenType: state.dataLogin?.tokenType ?? "",
          email: state.dataLogin?.user?.email ?? "",
          emailVerifiedAt: state.dataLogin?.user?.emailVerifiedAt ?? "",
          name: state.dataLogin?.user?.name ?? "",
          firstName: state.dataLogin?.user?.firstName ?? "",
          lastName: state.dataLogin?.user?.lastName ?? "",
          firstNameKana: state.dataLogin?.user?.firstNameKana ?? "",
          lastNameKana: state.dataLogin?.user?.lastNameKana ?? "",
          sex: state.dataLogin?.user?.sex,
          birthday: state.dataLogin?.user?.birthday ?? "",
          addressId: state.dataLogin?.user?.addressId ?? "",
          postcode: state.dataLogin?.user?.postcode ?? "",
          province: state.dataLogin?.user?.province ?? "",
          district: state.dataLogin?.user?.district ?? "",
          ward: state.dataLogin?.user?.ward ?? "",
          company: state.dataLogin?.user?.company ?? "",
          country: state.dataLogin?.user?.country ?? "",
          idProvince: state.dataLogin?.user?.idProvince ?? "",
          idDistrict: state.dataLogin?.user?.idDistrict ?? "",
          idWard: state.dataLogin?.user?.idWard ?? "",
          agencyId: state.dataLogin?.user?.agencyId ?? "",
          createdAt: state.dataLogin?.user?.createdAt,
          house: state.dataLogin?.user?.house,
          userName: state.dataLogin?.user?.userName,
          providerId: state.dataLogin?.user?.providerId,
          pathologicaldetail: state.dataLogin?.user?.pathologicaldetail,
          phoneVerifiedAt: state.dataLogin?.user?.phoneVerifiedAt,
          provider: state.dataLogin?.user?.provider,
          sku: state.dataLogin?.user?.sku,
          updatedAt: state.dataLogin?.user?.updatedAt,
          phone: state.dataLogin?.user?.phone ?? "",
          storeId: state.dataLogin?.user?.storeId ?? "",
          status: state.dataLogin?.user?.status ?? 0,
          group: state.dataLogin?.user?.group ?? 0,
          street: state.dataLogin?.user?.street ?? '',
          userId: state.dataLogin?.user?.userId ?? "",
          agencyName: state.dataLogin?.user?.agencyName ?? "",
          isLogin: true,
        );

        // reset client
        final appconfig = await Preference.getAppConfig();
        RestClient().init(
          appconfig?.xUrl ?? "",
          accessToken: appconfig?.xApiKey,
          authorization: state.dataLogin?.accessToken ?? "",
        );
        await Preference.setUserInfo(dataUser);

        // start update data stored
        final listItemsCartOrder = await _cartOrderRepository.getCartOrderRP();

        await CartDatabaseV2().insertProductFromDataGetCartOrderResponse(
            listProduct: listItemsCartOrder);

        // end update data stored

        // get cart product and set product
        cart.addCounter(setCounter: listItemsCartOrder.length);
      } else if (loginResponse.status == 200 &&
          loginResponse.isStatus != true) {
        emit(state.copyWith(
            sigupStatus: SigupStatus.sigupFailure,
            message: loginResponse.message ?? '',
            isSubmitSuccess: false));
      }
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }

      emit(state.copyWith(
          viewState: ViewState.error, errorMsg: error.toString()));
    } finally {
      emit(state.copyWith(isSubmitSuccess: false, isLoading: false));
    }
  }

//   class GoogleSignInProvider extends SignInProviders {
//   ///
//   @override
//   Future<UserCredential?> signIn() async {
//     // Trigger the authentication flow
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//     // Obtain the auth details from the request
//     final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

//     // Create a new credential
//     final credential = GoogleAuthProvider.credential(
//       idToken: googleAuth?.idToken,
//       accessToken: googleAuth?.accessToken,
//     );

//     // Once signed in, return the UserCredential
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }
// }
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        if (googleSignInAuthentication.accessToken != null) {
          emit(state.copyWith(
              accessToken: googleSignInAuthentication.accessToken));
        } else {
          emit(state.copyWith(accessToken: 'error'));
        }
      }
    } catch (error) {}
  }

  Future<void> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken?.token ?? '');

      FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } catch (error) {}
  }

  Future<void> signSocial(int type) async {
    if (type == 1) {
      await signInWithGoogle();
      if (state.accessToken == null) {
        emit(state.copyWith(isLoading: false));
      } else {
        emit(state.copyWith(
            isSubmitSuccess: false,
            verifyStatus: VerifyStatus.initial,
            isLoading: true));
        try {
          var loginResponse = await _customersRepository.loginGoogleRP(
              token: state.accessToken ?? '');
          if (loginResponse.status == 200 && loginResponse.isStatus == true) {
            emit(state.copyWith(
              isSubmitSuccess: true,
              dataLogin: loginResponse.data,
              message: loginResponse.message ?? '',
            ));
            UserState dataUser = UserState(
              avatar: state.dataLogin?.user?.avatar ?? "",
              id: state.dataLogin?.user?.id ?? "",
              accessToken: state.dataLogin?.accessToken ?? "",
              tokenType: state.dataLogin?.tokenType ?? "",
              email: state.dataLogin?.user?.email ?? "",
              emailVerifiedAt: state.dataLogin?.user?.emailVerifiedAt ?? "",
              name: state.dataLogin?.user?.name ?? "",
              firstName: state.dataLogin?.user?.firstName ?? "",
              lastName: state.dataLogin?.user?.lastName ?? "",
              firstNameKana: state.dataLogin?.user?.firstNameKana ?? "",
              lastNameKana: state.dataLogin?.user?.lastNameKana ?? "",
              sex: state.dataLogin?.user?.sex,
              birthday: state.dataLogin?.user?.birthday ?? "",
              addressId: state.dataLogin?.user?.addressId ?? "",
              postcode: state.dataLogin?.user?.postcode ?? "",
              province: state.dataLogin?.user?.province ?? "",
              district: state.dataLogin?.user?.district ?? "",
              ward: state.dataLogin?.user?.ward ?? "",
              company: state.dataLogin?.user?.company ?? "",
              country: state.dataLogin?.user?.country ?? "",
              idProvince: state.dataLogin?.user?.idProvince ?? "",
              idDistrict: state.dataLogin?.user?.idDistrict ?? "",
              idWard: state.dataLogin?.user?.idWard ?? "",
              agencyId: state.dataLogin?.user?.agencyId ?? "",
              createdAt: state.dataLogin?.user?.createdAt,
              house: state.dataLogin?.user?.house,
              userName: state.dataLogin?.user?.userName,
              providerId: state.dataLogin?.user?.providerId,
              pathologicaldetail: state.dataLogin?.user?.pathologicaldetail,
              phoneVerifiedAt: state.dataLogin?.user?.phoneVerifiedAt,
              provider: state.dataLogin?.user?.provider,
              sku: state.dataLogin?.user?.sku,
              updatedAt: state.dataLogin?.user?.updatedAt,
              phone: state.dataLogin?.user?.phone ?? "",
              storeId: state.dataLogin?.user?.storeId ?? "",
              status: state.dataLogin?.user?.status ?? 0,
              group: state.dataLogin?.user?.group ?? 0,
              street: state.dataLogin?.user?.street ?? '',
              userId: state.dataLogin?.user?.userId ?? "",
              agencyName: state.dataLogin?.user?.agencyName ?? "",
              isLogin: true,
            );

            Preference.setUserInfo(dataUser);
          } else if (loginResponse.status == 200 &&
              loginResponse.isStatus != true) {
            emit(state.copyWith(
                verifyStatus: VerifyStatus.verifyFailure,
                message: loginResponse.message ?? ''));
          }
        } catch (error, statckTrace) {
          if (kDebugMode) {
            print("$error + $statckTrace");
          }
          emit(state.copyWith(
              viewState: ViewState.error, errorMsg: error.toString()));
        } finally {
          emit(state.copyWith(isSubmitSuccess: false, isLoading: false));
        }
      }
    }

    if (type == 2) {
      await signInWithFacebook();
    }
  }
}
