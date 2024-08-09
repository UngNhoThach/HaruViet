import 'package:haruviet/data/reponsitory/product/models/data_list_product/list_product.dart';
import 'package:json_annotation/json_annotation.dart';

import 'category.dart';

part 'category_detail_response.g.dart';

@JsonSerializable()
class CategoryDetailResponse {
  Category? category;
  List<dynamic>? filterableAttributes;
  ListProduct? products;

  CategoryDetailResponse({
    this.category,
    this.filterableAttributes,
    this.products,
  });

  factory CategoryDetailResponse.fromJson(Map<String, dynamic> json) {
    return _$CategoryDetailResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CategoryDetailResponseToJson(this);
}
