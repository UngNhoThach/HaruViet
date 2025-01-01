import 'package:haruviet/api/services/customers/models/register_request.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/data_local/user_state.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/customers/customers_repository.dart';
import 'package:haruviet/helper/base_status_response.dart';
import 'package:haruviet/page/account/phone_authen/phone_authen_state.dart';
import 'package:haruviet/page/account/phone_authen/widgets/phone_authen_params.dart';
import 'package:haruviet/page/account/signup/widgets/verify_status.dart';
import 'package:flutter/foundation.dart';

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
        UserState dataUser = UserState(
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
          sex: state.dataRegister?.user?[0].sex,
          birthday: state.dataRegister?.user?[0].birthday ?? "",
          addressId: state.dataRegister?.user?[0].addressId ?? "",
          postcode: state.dataRegister?.user?[0].postcode ?? "",
          province: state.dataRegister?.user?[0].province ?? "",
          district: state.dataRegister?.user?[0].district ?? "",
          ward: state.dataRegister?.user?[0].ward ?? "",
          company: state.dataRegister?.user?[0].company ?? "",
          country: state.dataRegister?.user?[0].country ?? "",
          idProvince: state.dataRegister?.user?[0].idProvince ?? "",
          idDistrict: state.dataRegister?.user?[0].idDistrict ?? "",
          idWard: state.dataRegister?.user?[0].idWard ?? "",
          agencyId: state.dataRegister?.user?[0].agencyId ?? "",
          createdAt: state.dataRegister?.user?[0].createdAt,
          house: state.dataRegister?.user?[0].house,
          userName: state.dataRegister?.user?[0].userName,
          providerId: state.dataRegister?.user?[0].providerId,
          pathologicaldetail: state.dataRegister?.user?[0].pathologicaldetail,
          phoneVerifiedAt: state.dataRegister?.user?[0].phoneVerifiedAt,
          provider: state.dataRegister?.user?[0].provider,
          sku: state.dataRegister?.user?[0].sku,
          updatedAt: state.dataRegister?.user?[0].updatedAt,
          phone: state.dataRegister?.user?[0].phone ?? "",
          storeId: state.dataRegister?.user?[0].storeId ?? "",
          status: state.dataRegister?.user?[0].status ?? 0,
          group: state.dataRegister?.user?[0].group ?? 0,
          street: state.dataRegister?.user?[0].street ?? '',
          userId: state.dataRegister?.user?[0].userId ?? "",
          agencyName: state.dataRegister?.user?[0].agencyName ?? "",
          isLogin: true,
        );
        // SharedPreferences prefs = await SharedPreferences.getInstance();

        await Preference.setUserInfo(dataUser);
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
