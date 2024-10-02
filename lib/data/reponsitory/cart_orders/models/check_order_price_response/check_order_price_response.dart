import 'package:haruviet/api/services/cart_orders/models/check_order_price_request/attribute_check_price.dart';
import 'package:json_annotation/json_annotation.dart';

import 'gift_check_order_price_response.dart';

part 'check_order_price_response.g.dart';

@JsonSerializable()
class CheckOrderPriceResponse {
  List<String>? promotions;
  @JsonKey(name: 'free_shipping')
  bool? freeShipping;
  @JsonKey(name: 'discount_detail')
  int? discountDetail;
  @JsonKey(name: 'discount_order')
  int? discountOrder;
  GiftCheckOrderPriceResponse? gift;
  @JsonKey(name: 'product_id')
  String? productId;
  int? qty;
  AttributeCheckPrice? attribute;
  dynamic price;
  @JsonKey(name: 'total_price')
  int? totalPrice;

  CheckOrderPriceResponse({
    this.promotions,
    this.freeShipping,
    this.discountDetail,
    this.discountOrder,
    this.gift,
    this.productId,
    this.qty,
    this.attribute,
    this.price,
    this.totalPrice,
  });

  factory CheckOrderPriceResponse.fromJson(Map<String, dynamic> json) {
    return _$CheckOrderPriceResponseFromJson(json);
  }

  static List<CheckOrderPriceResponse> fromJsonArray(
    List<dynamic> jsonArray,
  ) {
    return jsonArray
        .map(
          (dynamic e) =>
              CheckOrderPriceResponse.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  Map<String, dynamic> toJson() => _$CheckOrderPriceResponseToJson(this);
}
