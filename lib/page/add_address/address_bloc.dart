import 'package:collection/collection.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:haruviet/data/reponsitory/address/address_repository.dart';
import 'package:haruviet/data/reponsitory/address/model/list_address/data_list_address.dart';
import 'package:haruviet/page/add_address/address_state.dart';

class AddressBloc extends BaseBloc<AddressState> {
  final AddressRepository _addressRepository = AddressRepository();
  AddressBloc() : super(const AddressState());
  getData({required String idAddressShipping, required bool isShipping}) async {
    emit(state.copyWith(
      isLoading: true,
    ));
    final userInfoLogin = await Preference.getUserInfo();
    final data = await _addressRepository.getListAddressRP(
      authorization: userInfoLogin?.accessToken ?? '',
    );

//  check if isShipping == true ? check box and select address shipping :  get all list addresses
    isShipping
        ? onChangeShippingAddress(
            idAddresses: idAddressShipping,
            listAddressesDefault: data.data!,
            isDefault: true)
        : emit(state.copyWith(
            listAddresses: data.data!,
          ));
    emit(state.copyWith(
      addressDefaultId: userInfoLogin?.addressId ?? '',
    ));
    emit(state.copyWith(
      isLoading: false,
    ));
  }

  onChangeShippingAddress(
      {DataListAddress? item,
      required String idAddresses,
      List<DataListAddress>? listAddressesDefault,
      required bool isDefault}) {
    DataListAddress? updatedItem;
    var listAddresses = isDefault ? listAddressesDefault : state.listAddresses;
    listAddresses = listAddresses!.map((item) {
      if (item.id == idAddresses) {
        updatedItem = item.copyWith(isShipping: true);
        return updatedItem!;
      }
      return item.copyWith(isShipping: false);
    }).toList();
    if (updatedItem != null) {
      onChangeAddressShipping(addressShipping: updatedItem!);
    }

    emit(state.copyWith(listAddresses: listAddresses));
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

  onChangeAddressShipping({required DataListAddress addressShipping}) {
    emit(state.copyWith(addressShipping: addressShipping));
  }

  onUpdateIdShipping({required DataListAddress addressShipping}) async {
    await Preference.setAddressShipping(addressShipping);
  }
}
