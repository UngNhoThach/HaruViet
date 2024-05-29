import 'package:dio/dio.dart';
import 'package:eco_app/api/exception/api_endpoints.dart';
import 'package:eco_app/base/base_service.dart';

class SettingService extends BaseService {
  Future<Response> getCountryListSV({required String idCountry}) async {
    final response = await get(
      SettingApi.getCountryList.replaceAll(RegExp('{id_country}'), idCountry),
    );
    return response;
  }

  Future<Response> getDistrictListSV({
    required String idProvince,
  }) async {
    final response = await get(
      SettingApi.getDistrictList
          .replaceAll(RegExp('{id_province}'), idProvince),
    );
    return response;
  }

  Future<Response> getWardListSV({
    required String idDistrict,
  }) async {
    final response = await get(
      SettingApi.getWardList.replaceAll(RegExp('{id_district}'), idDistrict),
    );
    return response;
  }
}
