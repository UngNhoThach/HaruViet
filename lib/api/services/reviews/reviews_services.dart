import 'dart:async';

import 'package:dio/dio.dart';
import 'package:haruviet/api/exception/api_endpoints.dart';
import 'package:haruviet/api/services/headers_request/headers_request.dart';
import 'package:haruviet/api/services/products/models/get_list_product_request.dart';
import 'package:haruviet/base/base_service.dart';

import 'models/post_review_request.dart';

class ReviewsService extends BaseService {
  ApiHeaders apiHeaders = ApiHeaders('');

  Future<Response> getListReviewSV(
      {required GetListProductRequest request,
      required String idProduct}) async {
    final response = await get(
      ReviewApi.getAllReviews.replaceAll(RegExp('{idProduct}'), idProduct),
      params: request.toJson(),
      //  headers: apiHeaders.appMobileHeaders
    );
    return response;
  }

  Future<Response> postReviewProductSV({
    required PostReviewRequest request,
  }) async {
    final response = await post(
      ReviewApi.postReviewProduct,
      data: request.toJson(),
      //   headers: apiHeaders.appMobileHeaders,
    );
    return response;
  }
}
