import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/enum.dart';
import 'package:eco_app/data/local/user_preferences.dart';
import 'package:eco_app/data/reponsitory/customers/customers_repository.dart';
import 'package:eco_app/page/account/forget_password/forget_password_state.dart';
import 'package:eco_app/page/account/signup/widgets/sigup_type.dart';
import 'package:eco_app/page/account/signup/widgets/verify_status.dart';
import 'package:flutter/foundation.dart';

// ForgetPassWordBloc
class ForgetPassWordBloc extends BaseBloc<ForgetPassWordState> {
  ForgetPassWordBloc() : super(const ForgetPassWordState());
  final CustomersRepository _customersRepository = CustomersRepository();

  getData() async {
    emit(state.copyWith(
      isLoading: true,
    ));
    try {} catch (error, statckTrace) {
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

  bool isEmailValid(String email) {
    RegExp regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regex.hasMatch(email);
  }

  // check is phone number
  bool isValidPhone(String phone) {
    RegExp regex = RegExp(r'((\+84|84|0)+([3|5|7|8|9])+([0-9]{8})\b)');
    return regex.hasMatch(phone);
  }

  checkTextValidator(String text) {
    if (isEmailValid(text)) {
      emit(state.copyWith(
        sigupType: SigupType.emailAddress,
        emailChange: text,
      ));
    } else if (isValidPhone(text)) {
      emit(state.copyWith(
        sigupType: SigupType.phoneNumber,
        emailChange: text,
      ));
    } else {
      emit(state.copyWith(
        sigupType: SigupType.error,
      ));
    }
  }

  onSubmit() async {
    emit(state.copyWith(verifyStatus: VerifyStatus.initial, isLoading: true));
    try {
      if (state.emailChange == null || state.emailChange == '') {
        return;
      }
      await checkTextValidator(state.emailChange ?? '');

      // if (state.sigupType == SigupType.phoneNumber) {
      //   emit(state.copyWith(
      //     verifyStatus: VerifyStatus.wattingCheck,
      //   ));
      // } else {
      var verifyResponse = await _customersRepository.forgetPassRP(
          username: state.emailChange ?? '');
      if (verifyResponse.status == 200 && verifyResponse.isStatus == true) {
        emit(state.copyWith(
            verifyStatus: VerifyStatus.wattingCheck,
            timeout: verifyResponse.data?.timeout,
            message: verifyResponse.message,
            errors: verifyResponse.errors));
      } else if (verifyResponse.status == 200 &&
          verifyResponse.isStatus != true) {
        if (verifyResponse.errors != null) {
          emit(state.copyWith(
              verifyStatus: VerifyStatus.verifyFailure,
              errors: verifyResponse.errors));
        }
      }
      //   }
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
}
