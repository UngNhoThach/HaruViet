import 'package:haruviet/data/reponsitory/category/models/atribute_category_response/attributes_category_response.dart';
import 'package:json_annotation/json_annotation.dart';

import 'category.dart';

part 'category_detail_response.g.dart';

@JsonSerializable()
class CategoryDetailResponse {
  Category? category;
  List<AtributesCategoryResponse>? filterableAttributes;

  CategoryDetailResponse({
    this.category,
    this.filterableAttributes,
  });

  factory CategoryDetailResponse.fromJson(Map<String, dynamic> json) {
    return _$CategoryDetailResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CategoryDetailResponseToJson(this);
}
