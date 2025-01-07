import 'dart:async';

import 'package:dio/dio.dart';
import 'package:haruviet/api/exception/api_endpoints.dart';
import 'package:haruviet/api/services/headers_request/headers_request.dart';
import 'package:haruviet/base/base_service.dart';

class BrandsService extends BaseService {
  ApiHeaders apiHeaders = ApiHeaders('');

  Future<Response> getTopBrand({required int pageSize}) async {
    final response = await get(
      BrandApi.getTopBrand
          .replaceAll(RegExp('{pageSize}'), pageSize.toString()),
      //  headers: apiHeaders.appMobileHeaders
    );
    return response;
  }

  //
  Future<Response> getListBrand(
      {required int pageSize, required int pageNumber}) async {
    final response = await get(
      BrandApi.getListBrand
          .replaceAll(RegExp('{pageSize}'), pageSize.toString())
          .replaceAll(RegExp('{pageNumber}'), pageNumber.toString()),
      //  headers: apiHeaders.appMobileHeaders
    );
    return response;
  }
}
