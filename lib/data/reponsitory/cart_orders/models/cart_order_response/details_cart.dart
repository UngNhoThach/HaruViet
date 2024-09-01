import 'package:json_annotation/json_annotation.dart';

import 'item_product.dart';

part 'details_cart.g.dart';

@JsonSerializable()
class DetailsCart {
  @JsonKey(name: 'total_product')
  int? totalProduct;
  @JsonKey(name: 'item_product')
  ItemProduct? itemProduct;

  DetailsCart({this.totalProduct, this.itemProduct});

  factory DetailsCart.fromJson(Map<String, dynamic> json) {
    return _$DetailsCartFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DetailsCartToJson(this);
}
