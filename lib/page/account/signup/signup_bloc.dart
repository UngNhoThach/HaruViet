import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/enum.dart';
import 'package:eco_app/data/local/user_preferences.dart';
import 'package:eco_app/data/reponsitory/customers/customers_repository.dart';
import 'package:eco_app/data/data_local/user_state.dart';
import 'package:eco_app/page/account/signup/signup_state.dart';
import 'package:eco_app/page/account/signup/widgets/verify_status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupBloc extends BaseBloc<SignupState> {
  SignupBloc() : super(const SignupState());
  final CustomersRepository _customersRepository = CustomersRepository();

  onChangeUserName(String? name) {
    emit(state.copyWith(
      userNameChange: name,
    ));
  }

  onChangePassword(String? password) {
    emit(state.copyWith(
      passwordChange: password,
    ));
  }

  onChangeRePassword(String? rePassword) {
    emit(state.copyWith(
      rePasswordChange: rePassword,
    ));
  }

  Future<void> google() async {
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

  onDisabledValidatorEmails() {
    emit(state.copyWith(errors: null));
  }

  // check is phone number or email
  checkTextValidator(String text) {
    emit(state.copyWith(
      emailChange: text,
    ));
    onDisabledValidatorEmails();
  }

  onChangeVerifyStatus() {
    emit(state.copyWith(
      verifyStatus: VerifyStatus.initial,
    ));
  }

  Future<void> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken?.token ?? '');

      FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } catch (error) {}
  }

  onSignup() async {
    emit(state.copyWith(verifyStatus: VerifyStatus.initial, isLoading: true));
    try {
      if (state.emailChange == null || state.emailChange == '') {
        return;
      }
      var verifyResponse = await _customersRepository.verifyRP(
          username: state.emailChange ?? '');
      if (verifyResponse.status == 200 && verifyResponse.isStatus == true) {
        emit(state.copyWith(
            verifyStatus: VerifyStatus.wattingCheck,
            timeout: verifyResponse.data?.timeout,
            errors: verifyResponse.errors));
      } else if (verifyResponse.status == 200 &&
          verifyResponse.isStatus != true) {
        if (verifyResponse.errors != null) {
          emit(state.copyWith(
              verifyStatus: VerifyStatus.verifyFailure,
              errors: verifyResponse.errors));
        }
      }
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      emit(state.copyWith(
          viewState: ViewState.error, errorMsg: error.toString()));
    } finally {
      emit(state.copyWith(
        isLoading: false,
        verifyStatus: VerifyStatus.initial,
      ));
    }
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
            UserInfoLogin dataUser = UserInfoLogin(
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
              sex: state.dataLogin?.user?.sex ?? "",
              birthDay: state.dataLogin?.user?.birthday ?? "",
              addressId: state.dataLogin?.user?.addressId ?? "",
              postCode: state.dataLogin?.user?.postcode ?? "",
              address1: state.dataLogin?.user?.address1 ?? "",
              address2: state.dataLogin?.user?.address2 ?? "",
              address3: state.dataLogin?.user?.address3 ?? "",
              company: state.dataLogin?.user?.company ?? "",
              country: state.dataLogin?.user?.country ?? "",
              phone: state.dataLogin?.user?.phone ?? "",
              storeId: state.dataLogin?.user?.storeId ?? "",
              status: state.dataLogin?.user?.status ?? 0,
              group: state.dataLogin?.user?.group ?? 0,
              userId: state.dataLogin?.user?.userId ?? "",
              agencyName: state.dataLogin?.user?.agencyName ?? "",
              isLogin: true,
            );
            SharedPreferences prefs = await SharedPreferences.getInstance();
            // avatar
            await prefs.setString('avatar', dataUser.avatar ?? '');
            await prefs.setString('id', dataUser.id ?? '');
            await prefs.setString('access_token', dataUser.accessToken ?? '');
            await prefs.setString('token_type', dataUser.tokenType ?? '');
            await prefs.setString('emai', dataUser.email ?? '');
            await prefs.setString(
                'email_verified_at', dataUser.emailVerifiedAt ?? '');
            await prefs.setString('name', dataUser.name ?? '');
            await prefs.setString('first_name', dataUser.firstName ?? '');
            await prefs.setString('last_name', dataUser.lastName ?? '');
            await prefs.setString(
                'first_name_kana', dataUser.firstNameKana ?? '');
            await prefs.setString(
                'last_name_kana', dataUser.lastNameKana ?? '');
            await prefs.setString(
                'sex', (dataUser.sex != null) ? dataUser.sex.toString() : '');
            await prefs.setString('birthday', dataUser.birthDay ?? '');
            await prefs.setString('address_id', dataUser.addressId ?? '');
            await prefs.setString('postcode', dataUser.postCode ?? '');
            await prefs.setString('address1', dataUser.address1 ?? '');
            await prefs.setString('address2', dataUser.address2 ?? '');
            await prefs.setString('address3', dataUser.address3 ?? '');
            await prefs.setString('company', dataUser.company ?? '');
            await prefs.setString('country', dataUser.country ?? '');
            await prefs.setString('phone', dataUser.phone ?? '');
            await prefs.setString('store_id', dataUser.storeId ?? '');
            await prefs.setString('status',
                dataUser.status != null ? dataUser.status.toString() : '');
            await prefs.setString('group',
                dataUser.group != null ? dataUser.group.toString() : '');
            await prefs.setString('user_id', dataUser.userId ?? '');
            await prefs.setString('agency_name', dataUser.agencyName ?? '');
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
