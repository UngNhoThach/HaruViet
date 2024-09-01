import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  String? id;
  String? image;
  String? alias;
//  ProductDescription? descriptions;
  String? title;

  Category({
    this.id,
    this.image,
    this.alias,
    this.title,
    // this.descriptions
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return _$CategoryFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
