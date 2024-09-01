import 'package:haruviet/data/reponsitory/category/models/list_category_response/descriptions_category.dart';
import 'package:json_annotation/json_annotation.dart';

import 'subcategory.dart';

part 'data_category.g.dart';

@JsonSerializable()
class DataCategory {
  String? id;
  String? image;
  String? alias;
  String? parent;
  DescriptionsCategory? descriptions;
  List<Subcategory>? subcategories;

  DataCategory({
    this.id,
    this.image,
    this.alias,
    this.parent,
    this.descriptions,
    this.subcategories,
  });

  factory DataCategory.fromJson(Map<String, dynamic> json) =>
      _$DataCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$DataCategoryToJson(this);
}
