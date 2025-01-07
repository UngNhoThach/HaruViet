import 'package:dio/dio.dart';
import 'package:haruviet/api/exception/api_endpoints.dart';
import 'package:haruviet/api/services/headers_request/headers_request.dart';
import 'package:haruviet/base/base_service.dart';

import 'models/get_list_product_request.dart';

class ProductService extends BaseService {
  ApiHeaders apiHeaders = ApiHeaders('');

  Future<Response> getListProductsSV(
      {required GetListProductRequest request}) async {
    final response = await get(
      ProductApi.getListProducts,
      // .replaceAll(RegExp('{size}'), size)
      // .replaceAll(RegExp('{totalproduct}'), totalproduct,
      params: request.toJson(),
      // headers: apiHeaders.appMobileHeaders
    );
    return response;
  }

  Future<Response> getProductDetailsSV({required String idProduct}) async {
    final response = await get(
      ProductApi.getProductDetails.replaceAll(RegExp('{idProduct}'), idProduct),
      //  headers: apiHeaders.appMobileHeaders
    );
    return response;
  }

  // search

  Future<Response> searchDefaultSV({required String keyword}) async {
    final response = await get(
      ProductApi.searchDefault.replaceAll(RegExp('{keyword}'), keyword),
    );
    return response;
  }
  //
}
