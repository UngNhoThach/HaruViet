import 'package:json_annotation/json_annotation.dart';

import 'price.dart';

part 'value.g.dart';

@JsonSerializable()
class Value {
  String? id;
  Price? price;
  @JsonKey(name: 'price_type')
  String? priceType;
  String? title;

  Value({this.id, this.price, this.priceType, this.title});

  factory Value.fromJson(Map<String, dynamic> json) => _$ValueFromJson(json);

  Map<String, dynamic> toJson() => _$ValueToJson(this);
}
