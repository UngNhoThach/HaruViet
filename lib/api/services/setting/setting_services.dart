import 'package:dio/dio.dart';
import 'package:eco_app/api/exception/api_endpoints.dart';
import 'package:eco_app/base/base_service.dart';

class SettingService extends BaseService {
  Future<Response> getCountryListSV() async {
    final response = await get(
      SettingApi.getCountryList,
    );
    return response;
  }

  Future<Response> getDistrictListSV({
    required String countryId,
  }) async {
    final response = await get(
      SettingApi.getDistrictList.replaceAll(RegExp('{countryId}'), countryId),
    );
    return response;
  }

  Future<Response> getWardListSV({
    required String districtId,
  }) async {
    final response = await get(
      SettingApi.getWardList.replaceAll(RegExp('{districtId}'), districtId),
    );
    return response;
  }
}
