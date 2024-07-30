import 'package:haruviet/api/services/products/product_services.dart';
import 'package:haruviet/data/reponsitory/product/models/list_product/list_product.dart';
import 'package:flutter/foundation.dart';

import 'models/list_product/data_product_detail.dart';

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

  Future<DataProductDetail> getProductDetailsRP(
      {required String idProduct}) async {
    try {
      final response = await _productService.getProductDetailsSV(
        idProduct: idProduct,
      );
      final result = DataProductDetail.fromJson(response.data);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
    return DataProductDetail();
  }
}
