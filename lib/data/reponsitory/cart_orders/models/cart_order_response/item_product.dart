import 'package:json_annotation/json_annotation.dart';

part 'item_product.g.dart';

@JsonSerializable()
class ItemProduct {
  String? image;
  String? name;
  String? price;
  int? qty;
  dynamic attribute;

  ItemProduct({
    this.image,
    this.name,
    this.price,
    this.qty,
    this.attribute,
  });

  factory ItemProduct.fromJson(Map<String, dynamic> json) {
    return _$ItemProductFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ItemProductToJson(this);
}
