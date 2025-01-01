import 'package:haruviet/api/services/address/address_services.dart';
import 'package:haruviet/data/reponsitory/address/model/address/data_address.dart';
import 'package:haruviet/data/reponsitory/address/model/list_address/list_address.dart';
import 'package:flutter/foundation.dart';

import 'model/list_address/data_list_address.dart';

class AddressRepository {
  final _addressService = AddressService();
  Future<DataAddress> addAddressRP({required DataListAddress request}) async {
    try {
      final response = await _addressService.addAddressSV(request: request);
      final result = DataAddress.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return DataAddress();
  }

  Future<ListAddress> getListAddressRP() async {
    try {
      final response = await _addressService.getListAddressSV();
      final result = ListAddress.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return ListAddress();
  }

  Future<ListAddress> deleteAddressSVRP({required String idAddress}) async {
    try {
      final response =
          await _addressService.deleteAddressSV(idAddress: idAddress);
      final result = ListAddress.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return ListAddress();
  }

  //
  Future<DataAddress> editAddressRP(
      {required DataListAddress request, required String idAddress}) async {
    try {
      final response = await _addressService.editAddressSV(
          request: request, idAddress: idAddress);
      final result = DataAddress.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return DataAddress();
  }
}
