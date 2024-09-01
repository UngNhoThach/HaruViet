import 'package:flutter/foundation.dart';
import 'package:haruviet/api/services/products/models/get_list_product_request.dart';
import 'package:haruviet/api/services/reviews/models/post_review_request.dart';
import 'package:haruviet/api/services/reviews/reviews_services.dart';
import 'package:haruviet/data/reponsitory/normal_response/normal_response.dart';

import 'models/reviews_data_response/reviews_data_response.dart';

class ReviewsRepository {
  final _reviewsService = ReviewsService();

  Future<ReviewsDataResponse> getProductFlashSaleRP(
      {required GetListProductRequest request,
      required String idProduct}) async {
    try {
      final response = await _reviewsService.getListReviewSV(
          request: request, idProduct: idProduct);
      final result = ReviewsDataResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return ReviewsDataResponse();
  }

  Future<NormalResponse> postReviewProductRP(
      {required PostReviewRequest request}) async {
    try {
      final response =
          await _reviewsService.postReviewProductSV(request: request);
      final result = NormalResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return NormalResponse();
  }
}
