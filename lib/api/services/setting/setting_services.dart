import 'package:dio/dio.dart';
import 'package:haruviet/api/exception/api_endpoints.dart';
import 'package:haruviet/api/services/headers_request/headers_request.dart';
import 'package:haruviet/base/base_service.dart';

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

  Future<Response> getAppDefault({
    required String apiKey,
    required String name,
  }) async {
    try {
      // change the default domain here
      final result = await getDefaultDomain(
        // "https://dev.sni.vn",
        SettingApi.domainRoot,
        headers: appDefaultHeader(name: name, apiKey: apiKey),
      );

      // Extract the data and headers from the result
      final data = result?['data'];
      final responseHeaders = result?['headers'];

      // Return a Response object using available headers even if data is null
      return Response(
        data: data ?? {}, // Return an empty map if data is null
        statusCode: 200,
        //  requestOptions: RequestOptions(path: "https://dev.sni.vn"),
        requestOptions: RequestOptions(path: SettingApi.domainRoot),
        headers: Headers.fromMap(responseHeaders ?? {}),
      );
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
