import 'package:haruviet/api/services/products/product_services.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/list_product.dart';
import 'package:flutter/foundation.dart';

import 'models/data_product_detail_response/data_product_detail_response.dart';
import 'models/data_search_default_response/search_default_response.dart';

class ProductRepository {
  final _productService = ProductService();

  Future<ListProduct> getListProductsRP(
      {required String size, required String totalproduct}) async {
    try {
      final response = await _productService.getListProductsSV(
        size: size,
        totalproduct: totalproduct,
      );
      final result = ListProduct.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return ListProduct();
  }

  Future<DataProductDetailResponse> getProductDetailsRP(
      {required String idProduct}) async {
    try {
      final response = await _productService.getProductDetailsSV(
        idProduct: idProduct,
      );
      final result = DataProductDetailResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return DataProductDetailResponse();
  }

  // search
  Future<SearchDefaultResponse> searchDefaultRP(
      {required String keyword}) async {
    try {
      final response = await _productService.searchDefaultSV(
        keyword: keyword,
      );
      final result = SearchDefaultResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return SearchDefaultResponse();
  }
}
