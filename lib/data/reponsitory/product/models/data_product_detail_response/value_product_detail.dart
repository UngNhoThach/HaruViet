import 'package:haruviet/data/reponsitory/product/models/price.dart';
import 'package:json_annotation/json_annotation.dart';

part 'value_product_detail.g.dart';

@JsonSerializable()
class Value {
  String? id;
  Price? price;
  @JsonKey(name: 'price_type')
  String? priceType;
  dynamic descriptions;

  Value({this.id, this.price, this.priceType, this.descriptions});

  factory Value.fromJson(Map<String, dynamic> json) => _$ValueFromJson(json);

  Map<String, dynamic> toJson() => _$ValueToJson(this);
}
