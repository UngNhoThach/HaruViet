import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/data_local/user_state.dart';
import 'package:haruviet/data/enum.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/address/address_repository.dart';
import 'package:haruviet/data/reponsitory/address/model/list_address/data_list_address.dart';
import 'package:haruviet/data/reponsitory/customers/customers_repository.dart';
import 'package:haruviet/data/reponsitory/customers/models/address_response.dart';
import 'package:haruviet/page/add_address/add_address/add_address_state.dart';
import 'package:haruviet/page/add_address/add_address/widgets/add_address_params.dart';
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
        idProvince: params.dataListAddress?.idProvince.toString() ?? '',
        idDistrict: params.dataListAddress?.idDistrict.toString() ?? '',
        idWard: params.dataListAddress?.idWard.toString() ?? '',
        district: params.dataListAddress?.district ?? '',
        ward: params.dataListAddress?.ward ?? '',
        province: params.dataListAddress?.province ?? '',
        house: params.dataListAddress?.house ?? '',
        street: params.dataListAddress?.street ?? '',
        lastName: params.dataListAddress?.lastName,
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
      house: temporaryResidenceAddress?.address,
      province: temporaryResidenceAddress?.city?.name,
      district: temporaryResidenceAddress?.district?.name,
      ward: temporaryResidenceAddress?.address ?? '',
      idProvince: temporaryResidenceAddress?.city?.id.toString(),
      idDistrict: temporaryResidenceAddress?.district?.id.toString(),
      idWard: temporaryResidenceAddress?.ward?.id.toString(),
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
      var verifyResponse = isUpdate
          ? await _addressRepository.editAddressRP(
              idAddress: state.dataListAddress?.id ?? '',
              request: DataListAddress(
                idDistrict: state.idDistrict != null
                    ? int.parse(state.idDistrict.toString())
                    : null,
                idProvince: state.idProvince != null
                    ? int.parse(state.idProvince.toString())
                    : null,
                idWard: state.idWard != null
                    ? int.parse(state.idWard.toString())
                    : null,
                firstName: state.name,
                province: state.province,
                district: state.district,
                ward: state.ward,
                house: state.house,
                country: 'VN',
                createdAt: DateTime.now(),
                customerId: '',
                firstNameKana: '',
                lastName: state.lastName,
                id: '',
                street: state.house,
                lastNameKana: '',
                postcode: '',
                updatedAt: DateTime.now(),
                phone: state.phone,
              ))
          : await _addressRepository.addAddressRP(
              request: DataListAddress(
              idDistrict: state.idDistrict != null
                  ? int.parse(state.idDistrict.toString())
                  : null,
              idProvince: state.idProvince != null
                  ? int.parse(state.idProvince.toString())
                  : null,
              idWard: state.idWard != null
                  ? int.parse(state.idWard.toString())
                  : null,
              firstName: state.name,
              street: state.house,
              province: state.province,
              district: state.district,
              ward: state.ward,
              house: state.house,
              country: 'VN',
              createdAt: DateTime.now(),
              customerId: '',
              firstNameKana: '',
              lastName: state.name,
              id: '',
              lastNameKana: '',
              postcode: '',
              updatedAt: DateTime.now(),
              phone: state.phone,
            ));
      if (verifyResponse.status == 200 && verifyResponse.isStatus == true) {
        // set default address
        if (state.textBtnswitchState) {
          await updateAddressDefault(id: verifyResponse.data?.id ?? '');
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
        request: UserState(
          addressId: id,
          agencyId: state.userInfoLogin?.agencyId ?? '',
          agencyName: state.userInfoLogin?.agencyName ?? '',
          avatar: state.userInfoLogin?.avatar ?? '',
          idProvince: state.idProvince,
          idDistrict: state.idDistrict,
          idWard: state.idWard,
          birthday: state.userInfoLogin?.birthday ?? '',
          company: state.userInfoLogin?.company ?? '',
          country: state.userInfoLogin?.country ?? '',
          firstName: state.name,
          firstNameKana: state.userInfoLogin?.firstNameKana ?? '',
          lastName: (state.userInfoLogin?.lastName == '' ||
                  state.userInfoLogin?.lastName == null)
              ? state.name
              : state.userInfoLogin?.lastName,
          lastNameKana: state.userInfoLogin?.lastNameKana ?? '',
          name: state.userInfoLogin?.birthday ?? '',
          pathologicaldetail: state.userInfoLogin?.pathologicaldetail,
          phone: state.phone ?? '',
          postcode: state.userInfoLogin?.postcode ?? '',
          provider: state.userInfoLogin?.provider ?? '',
          providerId: state.userInfoLogin?.providerId ?? '',
          sex: state.userInfoLogin?.sex ?? 0,
          userId: state.userInfoLogin?.userId ?? '',
          userName: (state.userInfoLogin?.userName == '' ||
                  state.userInfoLogin?.userName == null)
              ? state.name
              : state.userInfoLogin?.userName,
        ),
        authorization: state.accessToken ?? '');

    Preference.updateUserInfo({
      'address_id': updateAddressDefaultResponse.data?.addressId ?? '',
      'phone': updateAddressDefaultResponse.data?.phone ?? '',
      'first_name': updateAddressDefaultResponse.data?.firstName ?? '',
      'id_province': updateAddressDefaultResponse.data?.idProvince ?? '',
      'id_district': updateAddressDefaultResponse.data?.idDistrict ?? '',
      'id_ward': updateAddressDefaultResponse.data?.idWard ?? '',
      'ward': updateAddressDefaultResponse.data?.ward ?? '',
      'district': updateAddressDefaultResponse.data?.district ?? '',
      'province': updateAddressDefaultResponse.data?.province ?? '',
      'house': updateAddressDefaultResponse.data?.house ?? '',
    });
  }

  onDelete() async {
    emit(state.copyWith(isSubmitSuccess: false));
    try {
      var verifyResponse = await _addressRepository.deleteAddressSVRP(
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
