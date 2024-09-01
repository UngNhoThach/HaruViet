import 'package:json_annotation/json_annotation.dart';

part 'value_attributes.g.dart';

@JsonSerializable()
class ValueAttributes {
  @JsonKey(name: 'value_id')
  String? valueId;
  String? value;

  ValueAttributes({this.valueId, this.value});

  factory ValueAttributes.fromJson(Map<String, dynamic> json) =>
      _$ValueAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$ValueAttributesToJson(this);
}
