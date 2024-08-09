import 'package:flutter/foundation.dart';
import 'package:haruviet/api/services/category/models/category_services.dart';
import 'package:haruviet/data/reponsitory/category/models/category_detail_response/category_detail_response.dart';

class CategoryRepository {
  final _categoryService = CategoryService();

  Future<CategoryDetailResponse> getListProductsRP(
      {required String idCategory}) async {
    try {
      final response =
          await _categoryService.getDetailCategorySV(idCategory: idCategory);
      final result = CategoryDetailResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return CategoryDetailResponse();
  }
}
