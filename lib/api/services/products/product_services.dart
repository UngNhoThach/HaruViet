import 'package:dio/dio.dart';
import 'package:eco_app/api/exception/api_endpoints.dart';
import 'package:eco_app/api/services/headers_request/headers_request.dart';
import 'package:eco_app/base/base_service.dart';

class ProductService extends BaseService {
  ApiHeaders apiHeaders = ApiHeaders('');

  Future<Response> getListProductsSV(
      {required String size, required String totalproduct}) async {
    final response = await get(
        ProductApi.getListProducts
            .replaceAll(RegExp('{size}'), size)
            .replaceAll(RegExp('{totalproduct}'), totalproduct),
        headers: apiHeaders.appMobileHeaders);
    return response;
  }
}
