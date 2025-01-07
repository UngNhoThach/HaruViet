import 'package:flutter/foundation.dart';
import 'package:haruviet/api/services/brands_service/brands_service.dart';

import 'get_top_brands_response/get_top_brands_response.dart';

class BrandsRepository {
  final _brandsService = BrandsService();

  Future<GetTopBrandsResponse> getTopBrandRP({required int pageSize}) async {
    try {
      final response = await _brandsService.getTopBrand(
        pageSize: pageSize,
      );
      final result = GetTopBrandsResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return GetTopBrandsResponse();
  }

  // getListBrand

  Future<GetTopBrandsResponse> getListBrandRP(
      {required int pageSize, required int pageNumber}) async {
    try {
      final response = await _brandsService.getListBrand(
          pageSize: pageSize, pageNumber: pageNumber);
      final result = GetTopBrandsResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return GetTopBrandsResponse();
  }
}
