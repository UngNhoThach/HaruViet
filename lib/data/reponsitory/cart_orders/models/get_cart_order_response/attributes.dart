import 'package:haruviet/data/reponsitory/cart_orders/models/check_order_price_response/gift_check_order_price_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attributes.g.dart';

@JsonSerializable()
class AttributesGetCartOrder {
  List<String>? promotions;
  @JsonKey(name: 'free_shipping')
  bool? freeShipping;
  @JsonKey(name: 'discount_detail')
  int? discountDetail;
  @JsonKey(name: 'discount_order')
  int? discountOrder;
  GiftCheckOrderPriceResponse? gift;

  AttributesGetCartOrder({
    this.promotions,
    this.freeShipping,
    this.discountDetail,
    this.discountOrder,
    this.gift,
  });

  factory AttributesGetCartOrder.fromJson(Map<String, dynamic> json) {
    return _$AttributesGetCartOrderFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AttributesGetCartOrderToJson(this);
}
