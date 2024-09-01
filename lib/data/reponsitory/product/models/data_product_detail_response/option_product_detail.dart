import 'package:json_annotation/json_annotation.dart';

import 'value_product_detail.dart';

part 'option_product_detail.g.dart';

@JsonSerializable()
class Option {
  String? id;
  String? type;
  dynamic descriptions;
  @JsonKey(name: 'title')
  String? title;
  List<ValueOptionProduct>? values;

  Option({this.id, this.type, this.descriptions, this.values, this.title});

  factory Option.fromJson(Map<String, dynamic> json) {
    return _$OptionFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OptionToJson(this);

  Option copyWith({
    String? id,
    String? type,
    dynamic descriptions,
    String? title,
    List<ValueOptionProduct>? values,
  }) {
    return Option(
        id: id ?? this.id,
        type: type ?? this.type,
        descriptions: descriptions ?? this.descriptions,
        title: title ?? this.title,
        values: values ?? this.values);
  }
}
