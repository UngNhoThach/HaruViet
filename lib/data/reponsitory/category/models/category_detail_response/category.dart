import 'package:haruviet/data/reponsitory/product/models/product_description.dart';
import 'package:json_annotation/json_annotation.dart';

import 'subcategory.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  String? id;
  String? name;
  String? image;
  String? alias;
  ProductDescription? descriptions;
  List<Subcategory>? subcategories;

  Category({
    this.id,
    this.name,
    this.image,
    this.alias,
    this.descriptions,
    this.subcategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return _$CategoryFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
