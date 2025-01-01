import 'package:json_annotation/json_annotation.dart';

import 'option.dart';

part 'attribute.g.dart';

@JsonSerializable()
class Attribute {
  List<Option>? options;

  Attribute({this.options});

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return _$AttributeFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AttributeToJson(this);
}
