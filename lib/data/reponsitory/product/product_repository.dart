import 'package:haruviet/api/services/products/models/get_list_product_request.dart';
import 'package:haruviet/api/services/products/product_services.dart';
import 'package:flutter/foundation.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/data/reponsitory/respone_general.dart';

import 'models/data_search_default_response/search_default_response.dart';

class ProductRepository {
  final _productService = ProductService();

  Future<GeneralResponse> getListProductsRP(
      {required GetListProductRequest request}) async {
    try {
      final response =
          await _productService.getListProductsSV(request: request);
      final result = GeneralResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return GeneralResponse();
  }
  //   List<DataProduct>? data;

  Future<GeneralResponse> getProductFlashSaleRP(
      {required GetListProductRequest request}) async {
    try {
      final response =
          await _productService.getProductFlashSaleSV(request: request);
      final result = GeneralResponse.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return GeneralResponse();
  }

  Future<DataProduct> getProductDetailsRP({required String idProduct}) async {
    try {
      final response = await _productService.getProductDetailsSV(
        idProduct: idProduct,
      );
      final result = DataProduct.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return DataProduct();
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
