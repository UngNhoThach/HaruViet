import 'package:eco_app/api/services/customers/models/update_user_info_request/update_user_info_request.dart';
import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/enum.dart';
import 'package:eco_app/data/local/user_preferences.dart';
import 'package:eco_app/data/reponsitory/address/address_repository.dart';
import 'package:eco_app/data/reponsitory/address/model/list_address/data_list_address.dart';
import 'package:eco_app/data/reponsitory/customers/customers_repository.dart';
import 'package:eco_app/data/reponsitory/customers/models/address_response.dart';
import 'package:eco_app/page/add_address/add_address/add_address_state.dart';
import 'package:eco_app/page/add_address/add_address/widgets/add_address_params.dart';
import 'package:flutter/foundation.dart';

class AddNewAddressBloc extends BaseBloc<AddNewAddressState> {
  final AddressRepository _addressRepository = AddressRepository();
  final CustomersRepository _customersRepository = CustomersRepository();
  AddNewAddressBloc() : super(const AddNewAddressState());
  getData(AddNewAddressParams params) async {
    emit(state.copyWith(
      isLoading: true,
    ));

    final userInfoLogin = await Preference.getUserInfo();

    if (params.isUpdate) {
      emit(state.copyWith(
        dataListAddress: params.dataListAddress,
        name: params.dataListAddress?.firstName ?? '',
        phone: params.dataListAddress?.phone ?? '',
        address1: params.dataListAddress?.address1 ?? '',
        address2: params.dataListAddress?.address2 ??
            '', //' ${params.dataListAddress?.address3 ?? ''},
        address3: params.dataListAddress?.address3 ?? '',
        address: params.dataListAddress?.address3 ?? '',
      ));
    }

    emit(state.copyWith(
      userInfoLogin: userInfoLogin,
      accessToken: userInfoLogin?.accessToken,
    ));
    emit(state.copyWith(
      isLoading: false,
    ));
  }

  onChangeBtnswitchState(bool textBtnswitchState) {
    emit(state.copyWith(
      textBtnswitchState: textBtnswitchState,
    ));
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

  onChangeLocationDefault(int isLocationDefault) {
    emit(state.copyWith(
      isLocationDefault: isLocationDefault,
    ));
  }

  onChangePhoneNumber(String phoneNumber) {
    emit(state.copyWith(
      phone: phoneNumber,
    ));
  }

  onChangeName(String name) {
    emit(state.copyWith(
      name: name,
    ));
  }

  onSubmit(bool isUpdate) async {
    emit(state.copyWith(isSubmitSuccess: false));
    try {
      // editAddressRP
      var verifyResponse = isUpdate
          ? await _addressRepository.editAddressRP(
              idAddress: state.dataListAddress?.id ?? '',
              authorization: state.accessToken ?? '',
              request: DataListAddress(
                firstName: state.name,
                address1: state.address1,
                address2: state.address2,
                address3: state.address3,
                idAddress:
                    "{${state.address1ID},${state.address2ID},${state.address3ID}}",
                country: 'VN',
                createdAt: DateTime.now(),
                customerId: '',
                firstNameKana: '',
                lastName: '',
                id: '',
                lastNameKana: '',
                postcode: '',
                updatedAt: DateTime.now(),
                phone: state.phone,
              ))
          : await _addressRepository.addAddressRP(
              authorization: state.accessToken ?? '',
              request: DataListAddress(
                firstName: state.name,
                address1: state.address1,
                address2: state.address2,
                address3: state.address3,
                idAddress:
                    "{${state.address1ID},${state.address2ID},${state.address3ID}}",
                country: 'VN',
                createdAt: DateTime.now(),
                customerId: '',
                firstNameKana: '',
                lastName: '',
                id: '',
                lastNameKana: '',
                postcode: '',
                updatedAt: DateTime.now(),
                phone: state.phone,
              ));
      if (verifyResponse.status == 200 && verifyResponse.isStatus == true) {
        if (state.textBtnswitchState) {
          updateAddressDefault(id: verifyResponse.data?.id ?? '');
        }
        emit(state.copyWith(
            message: verifyResponse.message, isSubmitSuccess: true));
      } else if (verifyResponse.status == 200 &&
          verifyResponse.isStatus != true) {
        emit(state.copyWith(message: verifyResponse.message));
        emit(state.copyWith(isSubmitSuccess: false));
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
      ));
    }
  }

  updateAddressDefault({required String id}) async {
    var updateAddressDefaultResponse = await _customersRepository.updateInfoRP(
        request: UpdateUserInfoRequest(
            address1: state.address1,
            address2: state.address2,
            address3: state.address3,
            addressId: id,
            agencyId: state.userInfoLogin?.agencyId ?? 0,
            agencyName: state.userInfoLogin?.agencyName ?? '',
            avatar: state.userInfoLogin?.avatar ?? '',
            idAddress:
                "{${state.address1ID},${state.address2ID},${state.address3ID}}",
            birthday: state.userInfoLogin?.birthDay ?? '',
            company: state.userInfoLogin?.company ?? '',
            country: state.userInfoLogin?.country ?? '',
            firstName: state.name,
            firstNameKana: state.userInfoLogin?.firstNameKana ?? '',
            lastName: state.userInfoLogin?.lastName ?? '',
            lastNameKana: state.userInfoLogin?.lastNameKana ?? '',
            name: state.userInfoLogin?.birthDay ?? '',
            pathologicaldetail: state.userInfoLogin?.pathologicaldetail,
            phone: state.phone ?? '',
            postcode: state.userInfoLogin?.postCode ?? '',
            provider: state.userInfoLogin?.provider ?? '',
            providerId: state.userInfoLogin?.providerId ?? '',
            sex: state.userInfoLogin?.sex.toString() ?? '',
            userId: state.userInfoLogin?.userId ?? '',
            userName: state.userInfoLogin?.userName ?? ''),
        authorization: state.accessToken ?? '');

    await Preference.updateUserInfo({
      'address_id': updateAddressDefaultResponse.data?.addressId ?? '',
      'phone': updateAddressDefaultResponse.data?.phone ?? '',
      'first_name': updateAddressDefaultResponse.data?.firstName ?? '',
      'address1': updateAddressDefaultResponse.data?.address1 ?? '',
      'address2': updateAddressDefaultResponse.data?.address2 ?? '',
      'address3': updateAddressDefaultResponse.data?.address3 ?? '',
    });
  }

  onDelete() async {
    emit(state.copyWith(isSubmitSuccess: false));
    try {
      var verifyResponse = await _addressRepository.deleteAddressSVRP(
        authorization: state.accessToken ?? '',
        idAddress: state.dataListAddress?.id ?? '',
      );
      if (verifyResponse.status == 200 && verifyResponse.isStatus == true) {
        emit(state.copyWith(
            message: verifyResponse.message, isSubmitSuccess: true));
      } else if (verifyResponse.status == 200 &&
          verifyResponse.isStatus != true) {
        emit(state.copyWith(message: verifyResponse.message));
        emit(state.copyWith(isSubmitSuccess: false));
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
      ));
    }
  }
}
