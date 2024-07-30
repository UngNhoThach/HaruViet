import 'package:json_annotation/json_annotation.dart';

import 'description.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  String? id;
  String? image;
  String? alias;
  List<Description>? descriptions;

  Category({this.id, this.image, this.alias, this.descriptions});

  factory Category.fromJson(Map<String, dynamic> json) {
    return _$CategoryFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
