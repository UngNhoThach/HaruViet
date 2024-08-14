import 'package:flutter/material.dart';

class ProductListPageParams {
  ProductListPageParams({
    this.onReload,
    this.categoryID,
    this.subCategoryID,
  });
  final VoidCallback? onReload;
  final String? categoryID;
  final String? subCategoryID;
}
