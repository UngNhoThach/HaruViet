import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/data_local/user_state.dart';
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
        // userInfo: dataInfo.data,
        firstName: dataInfo.data?.firstName,
        lastName: dataInfo.data?.lastName,
        typeSex: dataInfo.data?.sex ?? 0,
        email: dataInfo.data?.email,
        birthDay:
            dataInfo.data?.birthday == null || dataInfo.data?.birthday == ""
                ? null
                : converStringtToDate(dataInfo.data?.birthday ?? ''),
        house: dataInfo.data?.house ?? '',
        idProvince: dataInfo.data?.idProvince ?? '',
        idDistrict: dataInfo.data?.idDistrict ?? '',
        idWard: dataInfo.data?.idWard ?? '',
        addressId: dataInfo.data?.addressId ?? '',
        phone: dataInfo.data?.phone ?? '',
        province: dataInfo.data?.province ?? '',
        district: dataInfo.data?.district ?? '',
        ward: dataInfo.data?.ward ?? '',
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
      house: temporaryResidenceAddress?.fullAddress,
      province: temporaryResidenceAddress?.city?.name ?? '',
      district: temporaryResidenceAddress?.district?.name ?? '',
      ward: temporaryResidenceAddress?.ward?.name ?? '',
      idProvince: temporaryResidenceAddress?.city?.id.toString(),
      idDistrict: temporaryResidenceAddress?.district?.id.toString(),
      idWard: temporaryResidenceAddress?.ward?.id.toString(),
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
          request: UserState(
              addressId: state.addressId,
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
          // dataUpdate: updateInfoResponse.data,
          message: updateInfoResponse.message ?? '',
        ));

        Preference.updateUserInfo({
          'address_id': updateInfoResponse.data?.addressId ?? '',
          'phone': updateInfoResponse.data?.phone ?? '',
          'first_name': updateInfoResponse.data?.firstName ?? '',
          'id_province': updateInfoResponse.data?.idProvince ?? '',
          'id_district': updateInfoResponse.data?.idDistrict ?? '',
          'id_ward': updateInfoResponse.data?.idWard ?? '',
          'ward': updateInfoResponse.data?.ward ?? '',
          'district': updateInfoResponse.data?.district ?? '',
          'province': updateInfoResponse.data?.province ?? '',
          'house': updateInfoResponse.data?.house ?? '',
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
