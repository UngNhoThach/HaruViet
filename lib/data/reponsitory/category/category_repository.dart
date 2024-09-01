import 'package:flutter/foundation.dart';
import 'package:haruviet/api/services/category/models/category_services.dart';
import 'package:haruviet/data/reponsitory/category/models/category_detail_response/category_detail_response.dart';

import 'models/list_category_response/list_category_response.dart';

class CategoryRepository {
  final _categoryService = CategoryService();

  Future<CategoryDetailResponse> getDetailCategoryRP(
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

  Future<ListCategoryResponse> getCategoryRP() async {
    try {
      final response = await _categoryService.getCategorySV();
      final result = ListCategoryResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return ListCategoryResponse();
  }
}
