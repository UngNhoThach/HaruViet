import 'package:eco_app/api/services/customers/models/register_request.dart';
import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/enum.dart';
import 'package:eco_app/data/local/user_preferences.dart';
import 'package:eco_app/data/reponsitory/customers/customers_repository.dart';
import 'package:eco_app/data/user/user_state.dart';
import 'package:eco_app/helper/base_status_response.dart';
import 'package:eco_app/page/account/phone_authen/phone_authen_state.dart';
import 'package:eco_app/page/account/phone_authen/widgets/phone_authen_params.dart';
import 'package:eco_app/page/account/signup/widgets/verify_status.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// PhoneAuthBloc
class PhoneAuthBloc extends BaseBloc<PhoneAuthState> {
  PhoneAuthBloc() : super(const PhoneAuthState());
  final CustomersRepository _customersRepository = CustomersRepository();

  getData(PhoneAuthParams params) async {
    emit(state.copyWith(
      isLoading: true,
    ));
    final nameGetOTP = replaceWithAsterisks(params.username);
    emit(state.copyWith(
      timeout: params.timeout,
      nameGetOTP: nameGetOTP,
      emailChange: params.username,
      passwordChange: params.password,
      rePasswordChange: params.passwordConfirmation,
      userNameChange: params.firstName,
    ));
    emit(state.copyWith(
      isLoading: true,
    ));
  }

  String replaceWithAsterisks(String input) {
    String value = input.substring(3, 7);
    int lengthToReplace = value.length;
    String asterisks = '*' * lengthToReplace;
    String replacedMessage = input.replaceAll(value, asterisks);
    return replacedMessage;
  }

  onChangeTimeUp(bool value) {
    emit(state.copyWith(
      isTimeUp: value,
    ));
  }

  onChangeCodeVerification(String? codeVerification) {
    emit(state.copyWith(
      codeVerification: int.parse(codeVerification.toString()),
    ));
  }

  onSubmit() async {
    emit(state.copyWith(
        baseStatusResponse: BaseStatusResponse.initial,
        isLoading: true,
        isSubmitSuccess: false));
    try {
      var registerResponse = await _customersRepository.registerRP(
          request: RegisterRequest(
        codeVerification: state.codeVerification.toString(),
        firstName: state.userNameChange,
        password: state.passwordChange,
        passwordConfirmation: state.rePasswordChange,
        username: state.emailChange,
      ));
      if (registerResponse.status == 200 && registerResponse.isStatus == true) {
        emit(state.copyWith(
            baseStatusResponse: BaseStatusResponse.susccess,
            dataRegister: registerResponse.data,
            message: registerResponse.message ?? '',
            isSubmitSuccess: true));
        UserInfoLogin dataUser = UserInfoLogin(
          avatar: state.dataRegister?.user?[0].avatar ?? "",
          id: state.dataRegister?.user?[0].id ?? "",
          accessToken: state.dataRegister?.accessToken ?? "",
          tokenType: state.dataRegister?.tokenType ?? "",
          email: state.dataRegister?.user?[0].email ?? "",
          emailVerifiedAt: state.dataRegister?.user?[0].emailVerifiedAt ?? "",
          name: state.dataRegister?.user?[0].name ?? "",
          firstName: state.dataRegister?.user?[0].firstName ?? "",
          lastName: state.dataRegister?.user?[0].lastName ?? "",
          firstNameKana: state.dataRegister?.user?[0].firstNameKana ?? "",
          lastNameKana: state.dataRegister?.user?[0].lastNameKana ?? "",
          sex: state.dataRegister?.user?[0].sex ?? "",
          birthDay: state.dataRegister?.user?[0].birthday ?? "",
          addressId: state.dataRegister?.user?[0].addressId ?? "",
          postCode: state.dataRegister?.user?[0].postcode ?? "",
          address1: state.dataRegister?.user?[0].address1 ?? "",
          address2: state.dataRegister?.user?[0].address2 ?? "",
          address3: state.dataRegister?.user?[0].address3 ?? "",
          company: state.dataRegister?.user?[0].company ?? "",
          country: state.dataRegister?.user?[0].country ?? "",
          phone: state.dataRegister?.user?[0].phone ?? "",
          storeId: state.dataRegister?.user?[0].storeId ?? "",
          status: state.dataRegister?.user?[0].status ?? 0,
          group: state.dataRegister?.user?[0].group ?? 0,
          userId: state.dataRegister?.user?[0].userId ?? "",
          agencyName: state.dataRegister?.user?[0].agencyName ?? "",
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
        await prefs.setString('first_name_kana', dataUser.firstNameKana ?? '');
        await prefs.setString('last_name_kana', dataUser.lastNameKana ?? '');
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
        await prefs.setString(
            'group', dataUser.group != null ? dataUser.group.toString() : '');
        await prefs.setString('user_id', dataUser.userId ?? '');
        await prefs.setString('agency_name', dataUser.agencyName ?? '');
        Preference.setUserInfo(dataUser);
      } else if (registerResponse.status == 200 &&
          registerResponse.isStatus != true) {
        emit(state.copyWith(
            baseStatusResponse: BaseStatusResponse.failure,
            message: registerResponse.message,
            isSubmitSuccess: false));
      }
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      emit(state.copyWith(
          viewState: ViewState.error, errorMsg: error.toString()));
    } finally {
      emit(state.copyWith(
        isSubmitSuccess: false,
        isLoading: false,
      ));
    }
  }

  onSignupReplay() async {
    emit(state.copyWith(
        verifyStatus: VerifyStatus.initial, isSubmitSuccess: false));
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
          isSubmitSuccess: true,
          message: verifyResponse.message ?? '',
        ));
      } else if (verifyResponse.status != 200 &&
          verifyResponse.isStatus != true) {
        emit(state.copyWith(
            verifyStatus: VerifyStatus.verifyFailure,
            message: verifyResponse.message ?? ''));
      }
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      emit(state.copyWith(
          viewState: ViewState.error, errorMsg: error.toString()));
    } finally {
      emit(state.copyWith(isSubmitSuccess: false));
    }
  }
}
