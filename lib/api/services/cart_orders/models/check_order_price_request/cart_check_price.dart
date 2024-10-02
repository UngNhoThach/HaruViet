import 'package:json_annotation/json_annotation.dart';

import 'attribute_check_price.dart';

part 'cart_check_price.g.dart';

@JsonSerializable()
class CartCheckPrice {
  @JsonKey(name: 'product_id')
  String? productId;
  int? qty;
  AttributeCheckPrice? attribute;

  CartCheckPrice({this.productId, this.qty, this.attribute});

  factory CartCheckPrice.fromJson(Map<String, dynamic> json) =>
      _$CartCheckPriceFromJson(json);

  Map<String, dynamic> toJson() => _$CartCheckPriceToJson(this);
}
