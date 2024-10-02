import 'package:json_annotation/json_annotation.dart';

import 'item_product.dart';

part 'details_cart.g.dart';

@JsonSerializable()
class DetailsCart {
  @JsonKey(name: 'total_product')
  int? totalProduct;
  @JsonKey(name: 'item_product')
  ItemProduct? itemProduct;
  @JsonKey(name: 'product_id')
  String? productId;
  String? name;
  String? image;
  String? price;
  int? qty;
  @JsonKey(name: 'total_price')
  String? totalPrice;
  String? tax;
  String? sku;
  @JsonKey(name: 'created_at')
  String? createdAt;
  String? currency;
  @JsonKey(name: 'exchange_rate')
  int? exchangeRate;
  dynamic attribute;

  DetailsCart({
    this.totalProduct,
    this.itemProduct,
    this.productId,
    this.name,
    this.createdAt,
    this.image,
    this.price,
    this.qty,
    this.totalPrice,
    this.tax,
    this.sku,
    this.currency,
    this.exchangeRate,
    this.attribute,
  });

  factory DetailsCart.fromJson(Map<String, dynamic> json) {
    return _$DetailsCartFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DetailsCartToJson(this);
}
