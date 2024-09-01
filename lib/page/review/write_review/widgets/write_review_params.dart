import 'package:flutter/material.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/data_product_detail_response.dart';

class WriteReviewParams {
  WriteReviewParams({
    required this.onReload,
    this.itemProductDetailResponse,
  });
  final VoidCallback onReload;
  final DataProductDetailResponse? itemProductDetailResponse;
}
