import 'package:flutter/material.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';

class WriteReviewParams {
  WriteReviewParams({
    required this.onReload,
    this.itemProductDetailResponse,
    this.idItem,
  });
  final VoidCallback onReload;
  final DataProduct? itemProductDetailResponse;
  final String? idItem;
}
