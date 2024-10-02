import 'package:dio/dio.dart';
import 'package:haruviet/api/exception/api_endpoints.dart';
import 'package:haruviet/api/services/headers_request/headers_request.dart';
import 'package:haruviet/api/services/products/models/get_list_product_request.dart';
import 'package:haruviet/base/base_service.dart';

class CategoryService extends BaseService {
  ApiHeaders apiHeaders = ApiHeaders('');
  Future<Response> getDetailCategorySV({required String idCategory}) async {
    final response = await get(
        CategoryApi.getDetailCategory
            .replaceAll(RegExp('{idCategory}'), idCategory),
        headers: apiHeaders.appMobileHeaders);
    return response;
  }

  // getCategory
  Future<Response> getCategorySV({
    required GetListProductRequest request,
  }) async {
    final response = await get(CategoryApi.getCategory,
        headers: apiHeaders.appMobileHeaders, params: request.toJson());
    return response;
  }
}
