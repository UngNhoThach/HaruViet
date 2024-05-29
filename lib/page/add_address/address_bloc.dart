import 'package:collection/collection.dart';
import 'package:eco_app/base/base_bloc.dart';
import 'package:eco_app/data/local/user_preferences.dart';
import 'package:eco_app/data/reponsitory/address/address_repository.dart';
import 'package:eco_app/data/reponsitory/address/model/list_address/data_list_address.dart';
import 'package:eco_app/page/add_address/address_state.dart';

class AddressBloc extends BaseBloc<AddressState> {
  final AddressRepository _addressRepository = AddressRepository();
  AddressBloc() : super(const AddressState());
  getData() async {
    emit(state.copyWith(
      isLoading: true,
    ));
    final userInfoLogin = await Preference.getUserInfo();
    final data = await _addressRepository.getListAddressRP(
      authorization: userInfoLogin?.accessToken ?? '',
    );
    emit(state.copyWith(
      addressDefaultId: userInfoLogin?.addressId ?? '',
      listAddresses: data.data,
      //  accessToken: userInfoLogin?.accessToken,
    ));
    emit(state.copyWith(
      isLoading: false,
    ));
  }

  onChaneDefalutLocation({required int index, required bool value}) {
    var address = List<DataListAddress>.from(state.listAddresses);
    address = address.mapIndexed((i, element) {
      if (index == i) {
        element.isDefault = value;
      }
      return element;
    }).toList();
    emit(state.copyWith(
      listAddresses: address,
    ));
  }
}
