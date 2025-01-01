import 'package:haruviet/api/rest_client.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/customers/customers_repository.dart';
import 'package:haruviet/data/data_local/user_state.dart';
import 'package:haruviet/page/account/signup/signup_state.dart';
import 'package:haruviet/page/account/signup/widgets/verify_status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
