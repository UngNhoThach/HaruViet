import 'package:json_annotation/json_annotation.dart';

import 'descriptions_category.dart';

part 'subcategory.g.dart';

@JsonSerializable()
class Subcategory {
  String? id;
  String? image;
  String? alias;
  String? parent;
  DescriptionsCategory? descriptions;
  List<dynamic>? subcategories;

  Subcategory({
    this.id,
    this.image,
    this.alias,
    this.parent,
    this.descriptions,
    this.subcategories,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return _$SubcategoryFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SubcategoryToJson(this);
}
