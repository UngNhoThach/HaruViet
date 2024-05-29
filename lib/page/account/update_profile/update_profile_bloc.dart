import 'package:eco_app/api/services/customers/models/update_user_info_request/update_user_info_request.dart';
import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/enum.dart';
import 'package:eco_app/data/local/user_preferences.dart';
import 'package:eco_app/data/reponsitory/customers/customers_repository.dart';
import 'package:eco_app/data/reponsitory/customers/models/address_response.dart';
import 'package:eco_app/data/user/user_state.dart';
import 'package:eco_app/helper/base_status_response.dart';
import 'package:eco_app/helper/date_time.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'update_profile_state.dart';

class UpdateProfileBloc extends BaseBloc<UpdateProfileState> {
  UpdateProfileBloc() : super(const UpdateProfileState());

  final CustomersRepository _customersRepository = CustomersRepository();
  getData() async {
    emit(state.copyWith(
      isLoading: true,
    ));
// v1/customer/upinfo
    try {
      final userInfoLogin = await Preference.getUserInfo();
      final dataInfo = await _customersRepository.getInfoUserRP(
          authorization: userInfoLogin?.accessToken ?? '');

      // if (userInfoLogin?.address == null || userInfoLogin?.address == '') {
      // } else {
      //   final AddressUser addressUserData = AddressUser(
      //       temporaryResidenceAddress: AddressResponse(
      //     address: userInfoLogin?.address,
      //     fullAddress: userInfoLogin?.address,
      //     city: ItemBaseResponse(
      //         id: int.parse(userInfoLogin!.address1ID.toString()),
      //         name: userInfoLogin.address1),
      //     district: ItemBaseResponse(
      //         id: int.parse(userInfoLogin.address2ID.toString()),
      //         name: userInfoLogin.address2),
      //     ward: ItemBaseResponse(
      //         id: int.parse(userInfoLogin.address3ID.toString()),
      //         name: userInfoLogin.address3),
      //   ));
      //   emit(state.copyWith(
      //     addressUserData: addressUserData,
      //     address: addressUserData.temporaryResidenceAddress?.fullAddress,
      //     address1: addressUserData.temporaryResidenceAddress?.city?.name,
      //     address2: addressUserData.temporaryResidenceAddress?.district?.name,
      //     address3: addressUserData.temporaryResidenceAddress?.ward?.name,
      //     address1ID:
      //         addressUserData.temporaryResidenceAddress?.city?.id.toString(),
      //     address2ID: addressUserData.temporaryResidenceAddress?.district?.id
      //         .toString(),
      //     address3ID:
      //         addressUserData.temporaryResidenceAddress?.ward?.id.toString(),
      //   ));
      // }
      if (userInfoLogin?.address3 == null && userInfoLogin?.address2 == null) {}
      emit(state.copyWith(
          userInfo: dataInfo.data,
          userInfoLogin: userInfoLogin,
          firstName: userInfoLogin?.firstName ?? '',
          lastName: userInfoLogin?.lastName ?? '',
          email: userInfoLogin?.email ?? '',
          birthDay:
              userInfoLogin?.birthDay == null || userInfoLogin?.birthDay == ""
                  ? null
                  : converStringtToDate(userInfoLogin!.birthDay!),
          phone: userInfoLogin?.phone ?? '',
          typeSex: userInfoLogin?.sex != null
              ? int.tryParse(userInfoLogin!.sex.toString())
              : null));
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
    var addressUserData = state.addressUserData;
    addressUserData = addressUserData.copyWith(
      permanentAddress: addressUserData.permanentAddress,
      temporaryResidenceAddress: temporaryResidenceAddress,
      hometownAddress: addressUserData.hometownAddress,
      birthCertificateIssuanceAddress:
          addressUserData.birthCertificateIssuanceAddress,
    );
    emit(state.copyWith(
      addressUserData: addressUserData,
      address: temporaryResidenceAddress?.fullAddress,
      address1: temporaryResidenceAddress?.city?.name,
      address2: temporaryResidenceAddress?.district?.name,
      address3: temporaryResidenceAddress?.ward?.name,
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
              address2: '${state.address3},  ${state.address2}',
              address3: state.address,
              phone: state.phone.toString(),
              country: 'VN',
              firstName: state.firstName,
              lastName: state.lastName,
              sex: state.typeSex.toString(),
              birthday: state.birthDay?.format(pattern: dd_mm_yyyy)),
          authorization: state.userInfoLogin?.accessToken ?? '');
      if (updateInfoResponse.status == 200 &&
          updateInfoResponse.isStatus == true) {
        emit(state.copyWith(
          dataUpdate: updateInfoResponse.data,
          message: updateInfoResponse.message ?? '',
        ));
        UserInfoLogin dataUser = UserInfoLogin(
          avatar: state.userInfoLogin?.avatar ?? "",
          id: state.userInfoLogin?.id ?? "",
          accessToken: state.userInfoLogin?.accessToken ?? "",
          tokenType: state.userInfoLogin?.tokenType ?? "",
          email: state.userInfoLogin?.email == null ||
                  state.userInfoLogin?.email == ""
              ? state.email
              : state.userInfoLogin?.email,
          emailVerifiedAt: state.userInfoLogin?.emailVerifiedAt ?? "",
          name: state.userInfoLogin?.name ?? "",
          firstName: state.firstName ?? "",
          lastName: state.lastName ?? "",
          firstNameKana: state.userInfoLogin?.firstNameKana ?? "",
          lastNameKana: state.userInfoLogin?.lastNameKana ?? "",
          sex: state.typeSex != null ? state.typeSex?.toInt() : 0,
          birthDay: state.birthDay?.format(pattern: dd_mm_yyyy) ?? "",
          addressId: state.userInfoLogin?.addressId ?? "",
          postCode: state.userInfoLogin?.postCode ?? "",
          company: state.userInfoLogin?.company ?? "",
          country: state.userInfoLogin?.country ?? "",
          phone: state.userInfoLogin?.phone == null ||
                  state.userInfoLogin?.phone == ""
              ? state.phone
              : state.userInfoLogin?.phone,
          storeId: state.userInfoLogin?.storeId ?? "",
          status: state.userInfoLogin?.status ?? 0,
          group: state.userInfoLogin?.group ?? 0,
          userId: state.userInfoLogin?.userId ?? "",
          agencyName: state.userInfoLogin?.agencyName ?? "",
          //
          // address: state.address,
          address1: state.address1,
          address2: state.address2,
          address3: state.address3,
          address1ID: state.address1ID,
          address2ID: state.address2ID,
          address3ID: state.address3ID,
          isLogin: true,
        );
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // avatar
        //   await prefs.setString('address', dataUser.address ?? '');
        await prefs.setString('address1', dataUser.address1 ?? '');
        await prefs.setString('address2', dataUser.address2 ?? '');
        await prefs.setString('address3', dataUser.address3 ?? '');
        await prefs.setString('address1ID', dataUser.address1ID ?? '');
        await prefs.setString('address2ID', dataUser.address2ID ?? '');
        await prefs.setString('address3ID', dataUser.address3ID ?? '');
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
