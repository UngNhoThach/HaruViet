import 'package:haruviet/api/services/customers/models/update_user_info_request/update_user_info_request.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/customers/customers_repository.dart';
import 'package:haruviet/data/reponsitory/customers/models/address_response.dart';
import 'package:haruviet/helper/base_status_response.dart';
import 'package:haruviet/helper/date_time.dart';
import 'package:flutter/foundation.dart';

import 'update_profile_state.dart';

class UpdateProfileBloc extends BaseBloc<UpdateProfileState> {
  UpdateProfileBloc() : super(const UpdateProfileState());

  final CustomersRepository _customersRepository = CustomersRepository();

  getData() async {
    emit(state.copyWith(
      isLoading: true,
    ));
    try {
      final userInfoLogin = await Preference.getUserInfo();
      final dataInfo = await _customersRepository.getInfoUserRP(
          authorization: userInfoLogin?.accessToken ?? '');
      emit(state.copyWith(
        userInfoLogin: userInfoLogin,
        userInfo: dataInfo.data,
        firstName: dataInfo.data?.firstName,
        lastName: dataInfo.data?.lastName,
        typeSex: dataInfo.data?.sex ?? 0,
        email: dataInfo.data?.email,
        birthDay:
            dataInfo.data?.birthday == null || dataInfo.data?.birthday == ""
                ? null
                : converStringtToDate(dataInfo.data?.birthday ?? ''),
        phone: dataInfo.data?.phone ?? '',
        address1: dataInfo.data?.address1 ?? '',
        address2: dataInfo.data?.address2 ??
            '', //' ${params.dataListAddress?.address3 ?? ''},
        address3: dataInfo.data?.address3 ?? '',
      ));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      emit(state.copyWith(
          viewState: ViewState.error, errorMsg: error.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  onChangeTemporaryResidenceAddressUser({
    AddressResponse? temporaryResidenceAddress,
  }) {
    emit(state.copyWith(
      address: temporaryResidenceAddress?.fullAddress,
      address1: temporaryResidenceAddress?.city?.name,
      address2:
          '${temporaryResidenceAddress?.ward?.name}, ${temporaryResidenceAddress?.district?.name}',
      address3: temporaryResidenceAddress?.address ?? '',
      address1ID: temporaryResidenceAddress?.city?.id.toString(),
      address2ID: temporaryResidenceAddress?.district?.id.toString(),
      address3ID: temporaryResidenceAddress?.ward?.id.toString(),
    ));
  }

  onChangSex(int typeSex) {
    emit(state.copyWith(
      typeSex: typeSex,
    ));
  }

  onChangeEmail(String email) {
    emit(state.copyWith(
      email: email,
    ));
  }

  onChangeFirstName(String firstName) {
    emit(state.copyWith(
      firstName: firstName,
    ));
  }

  onChangeLastName(String lastName) {
    emit(state.copyWith(
      lastName: lastName,
    ));
  }

  onChangePhone(String phone) {
    emit(state.copyWith(
      phone: phone,
    ));
  }

  onChangeBirthDay(DateTime birthDay) {
    emit(state.copyWith(
      birthDay: birthDay,
    ));
  }

  onSubmit() async {
    emit(state.copyWith(
      isSubmitSuccess: false,
      isLoading: true,
      baseStatusResponse: BaseStatusResponse.initial,
    ));
    try {
      var updateInfoResponse = await _customersRepository.updateInfoRP(
          request: UpdateUserInfoRequest(
              address1: state.address1,
              address2: state.address2,
              address3: state.address3,
              phone: state.phone.toString(),
              country: 'VN',
              firstName: state.firstName,
              lastName: state.lastName,
              sex: state.typeSex,
              birthday: state.birthDay?.format(pattern: yyyy_mm_dd)),
          authorization: state.userInfoLogin?.accessToken ?? '');
      if (updateInfoResponse.status == 200 &&
          updateInfoResponse.isStatus == true) {
        emit(state.copyWith(
          dataUpdate: updateInfoResponse.data,
          message: updateInfoResponse.message ?? '',
        ));

        Preference.updateUserInfo({
          'emai': state.email ?? '',
          'first_name': state.firstName ?? "",
          'last_name': state.lastName ?? "",
          'sex': state.typeSex,
          'birthday': state.birthDay?.format(pattern: dd_mm_yyyy) ?? "",
          'phone': state.phone ?? '',
          'address_id':
              "${state.address1ID},${state.address2ID},${state.address3ID}",
          'address1': state.address1 ?? '',
          'address2': state.address2 ?? '',
          'address3': state.address3 ?? '',
        });
        emit(state.copyWith(
            baseStatusResponse: BaseStatusResponse.susccess,
            isSubmitSuccess: true));
      } else if (updateInfoResponse.status == 200 &&
          updateInfoResponse.isStatus != true) {
        emit(state.copyWith(
            message: updateInfoResponse.message ?? '',
            baseStatusResponse: BaseStatusResponse.failure,
            isSubmitSuccess: false));
      }
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print('$error + $statckTrace');
      }
      emit(state.copyWith(
          viewState: ViewState.error, errorMsg: error.toString()));
    } finally {
      emit(state.copyWith(isSubmitSuccess: false, isLoading: false));
    }
  }
}
