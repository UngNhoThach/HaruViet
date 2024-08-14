import 'package:haruviet/data/reponsitory/product/models/product_description.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subcategory.g.dart';

@JsonSerializable()
class Subcategory {
  String? id;
  dynamic name;
  String? image;
  String? alias;
  ProductDescription? descriptions;

  Subcategory({
    this.id,
    this.name,
    this.image,
    this.alias,
    this.descriptions,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return _$SubcategoryFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SubcategoryToJson(this);
}
