import 'package:json_annotation/json_annotation.dart';

import 'value_product_detail.dart';

part 'option_product_detail.g.dart';

@JsonSerializable()
class Option {
  String? id;
  String? type;
  dynamic descriptions;
  List<Value>? values;

  Option({this.id, this.type, this.descriptions, this.values});

  factory Option.fromJson(Map<String, dynamic> json) {
    return _$OptionFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OptionToJson(this);
}
