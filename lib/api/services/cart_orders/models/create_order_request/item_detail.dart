import 'package:json_annotation/json_annotation.dart';

import 'attribute.dart';

part 'item_detail.g.dart';

@JsonSerializable()
class ItemDetail {
  @JsonKey(name: 'store_id')
  String? storeId;
  @JsonKey(name: 'product_id')
  String? productId;
  String? name;
  int? price;
  int? qty;
  @JsonKey(name: 'total_price')
  int? totalPrice;
  int? tax;
  String? sku;
  String? currency;
  @JsonKey(name: 'exchange_rate')
  int? exchangeRate;
  Attribute? attribute;

  ItemDetail({
    this.storeId,
    this.productId,
    this.name,
    this.price,
    this.qty,
    this.totalPrice,
    this.tax,
    this.sku,
    this.currency,
    this.exchangeRate,
    this.attribute,
  });

  factory ItemDetail.fromJson(Map<String, dynamic> json) {
    return _$ItemDetailFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ItemDetailToJson(this);
}
