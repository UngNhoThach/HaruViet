import 'package:eco_app/api/services/customers/models/update_password_phone_number_request/update_password_phone_number_request.dart';
import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/enum.dart';
import 'package:eco_app/data/reponsitory/customers/customers_repository.dart';
import 'package:eco_app/helper/base_status_response.dart';
import 'package:eco_app/page/account/signup/widgets/verify_status.dart';
import 'package:flutter/foundation.dart';

import 'reset_password_state.dart';
import 'widgets/reset_password_params.dart';

// ResetPassWordBloc
class ResetPassWordBloc extends BaseBloc<ResetPassWordState> {
  final ResetPasswordParams params;
  String replaceWithAsterisks(String input) {
    String value = input.substring(3, 7);
    int lengthToReplace = value.length;
    String asterisks = '*' * lengthToReplace;
    String replacedMessage = input.replaceAll(value, asterisks);
    return replacedMessage;
  }

  ResetPassWordBloc(
    this.params,
  ) : super(const ResetPassWordState());
  final CustomersRepository _customersRepository = CustomersRepository();

  getData() async {
    emit(state.copyWith(
      isLoading: true,
    ));
    try {
      final nameGetOTP = replaceWithAsterisks(params.phoneNumber ?? '');

      emit(state.copyWith(nameGetOTP: nameGetOTP, timeout: params.timeout));
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

  onChangePassword(String? password) {
    emit(state.copyWith(
      password: password,
    ));
  }

  onChangeRePassword(String? rePassword) {
    emit(state.copyWith(
      rePassword: rePassword,
    ));
  }

  // onFetch({
  //   required int page,
  // }) async {
  //   try {
  //     if (page == startPage) {
  //       emit(
  //         state.copyWith(
  //           newDataList: null,
  //           canLoadMore: false,
  //         ),
  //       );
  //     }
  //     final data = await _laborRelationsRepository
  //         .filterTerminationHandoverConfirmerList(
  //             request: FilterTerminationHandoverConfirmerListRequest(
  //       confirmerId: state.confirmerId,
  //       status: state.status,
  //       organizationId: state.organizationId,
  //       limit: state.limit,
  //       page: page,
  //       hascount: true,
  //     ));

  //     final dataList =
  //         List<TerminationHandoverConfirmerResponse>.from(state.dataList)
  //           ..addAll(data.many ?? []);

  //     final maxLoadMore = ((data.count ?? 0) / state.limit).floor();

  //     final canLoadMore = page <= maxLoadMore;

  //     emit(state.copyWith(
  //       dataList: dataList,
  //       newDataList: data.many,
  //       currentPage: page,
  //       canLoadMore: canLoadMore,
  //     ));
  //   } catch (error, statckTrace) {
  //     if (kDebugMode) {
  //       print("$error + $statckTrace");
  //     }

  //     emit(state.copyWith(
  //         viewState: ViewState.error, errorMsg: error.toString()));
  //   }
  // }
  onChangeCodeVerification(String? codeVerification) {
    emit(state.copyWith(
      codeVerification: int.parse(codeVerification.toString()),
    ));
  }

  onSubmitUpdatePassWord() async {
    emit(state.copyWith(
        baseStatusResponse: BaseStatusResponse.initial,
        isLoading: true,
        isSubmitSuccessUpdate: false));
    try {
      var updatePassWordResponse = await _customersRepository.updatePassWordRP(
          request: UpdatePasswordPhoneNumberRequest(
        codeVerification: state.codeVerification.toString(),
        password: state.password,
        passwordConfirmation: state.rePassword,
        phone: params.phoneNumber,
      ));
      if (updatePassWordResponse.status == 200 &&
          updatePassWordResponse.isStatus == true) {
        emit(state.copyWith(
            baseStatusResponse: BaseStatusResponse.susccess,
            message: updatePassWordResponse.message ?? '',
            isSubmitSuccessUpdate: true));
      } else if (updatePassWordResponse.status == 200 &&
          updatePassWordResponse.isStatus != true) {
        emit(state.copyWith(
            baseStatusResponse: BaseStatusResponse.failure,
            message: updatePassWordResponse.message,
            isSubmitSuccessUpdate: false));
      }
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      emit(state.copyWith(
          viewState: ViewState.error, errorMsg: error.toString()));
    } finally {
      emit(state.copyWith(
        isSubmitSuccessUpdate: false,
        isLoading: false,
      ));
    }
  }

  onSubmit() async {
    emit(state.copyWith(verifyStatus: VerifyStatus.initial, isLoading: true));
    try {
      if (params.phoneNumber == null || params.phoneNumber == '') {
        return;
      }

      var verifyResponse = await _customersRepository.forgetPassRP(
          username: params.phoneNumber ?? '');
      if (verifyResponse.status == 200 && verifyResponse.isStatus == true) {
        emit(state.copyWith(
            verifyStatus: VerifyStatus.wattingCheck,
            timeout: verifyResponse.data?.timeout,
            message: verifyResponse.message,
            errors: verifyResponse.errors));
      } else if (verifyResponse.status == 200 &&
          verifyResponse.isStatus != true) {
        emit(state.copyWith(
            verifyStatus: VerifyStatus.verifyFailure,
            message: verifyResponse.message));
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
}
