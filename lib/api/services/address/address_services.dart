import 'package:dio/dio.dart';
import 'package:eco_app/api/exception/api_endpoints.dart';
import 'package:eco_app/api/services/headers_request/headers_request.dart';
import 'package:eco_app/base/base_service.dart';
import 'package:eco_app/data/reponsitory/address/model/list_address/data_list_address.dart';

class AddressService extends BaseService {
  ApiHeaders apiHeaders = ApiHeaders('');

  Future<Response> addAddressSV(
      {required DataListAddress request, required String authorization}) async {
    final response = await post(AddressApi.addAddress,
        data: request.toJson(),
        headers: ApiHeaders(authorization).appMobileHeaders);
    return response;
  }

  Future<Response> getListAddressSV({required String authorization}) async {
    final response = await get(AddressApi.getListAddress,
        headers: ApiHeaders(authorization).appMobileHeaders);
    return response;
  }

  Future<Response> deleteAddressSV(
      {required String authorization, required String idAddress}) async {
    final response = await get(
        AddressApi.deleteAddress.replaceAll(RegExp('{idAddress}'), idAddress),
        headers: ApiHeaders(authorization).appMobileHeaders);
    return response;
  }

  Future<Response> getAddressIdSV(
      {required String authorization, required String idAddress}) async {
    final response = await get(
        AddressApi.getAddressId.replaceAll(RegExp('{idAddress}'), idAddress),
        headers: ApiHeaders(authorization).appMobileHeaders);
    return response;
  }

  //
  Future<Response> editAddressSV(
      {required DataListAddress request,
      required String authorization,
      required String idAddress}) async {
    final response = await post(
        AddressApi.postEditAddress.replaceAll(RegExp('{idAddress}'), idAddress),
        data: request.toJson(),
        headers: ApiHeaders(authorization).appMobileHeaders);

    return response;
  }
}
