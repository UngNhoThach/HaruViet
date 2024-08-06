import 'package:haruviet/data/reponsitory/product/models/product_description.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  String? id;
  String? image;
  String? alias;
  List<ProductDescription>? descriptions;

  Category({this.id, this.image, this.alias, this.descriptions});

  factory Category.fromJson(Map<String, dynamic> json) {
    return _$CategoryFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
