import 'package:json_annotation/json_annotation.dart';

part 'promotiondetail_product_detail.g.dart';

@JsonSerializable()
class Promotiondetail {
  String? id;
  @JsonKey(name: 'promotion_id')
  String? promotionId;
  @JsonKey(name: 'discount_value')
  dynamic discountValue;
  @JsonKey(name: 'discount_percent')
  String? discountPercent;
  String? description;
  @JsonKey(name: 'gift_product_id')
  dynamic giftProductId;
  @JsonKey(name: 'gift_quantity')
  dynamic giftQuantity;
  @JsonKey(name: 'promotion_type')
  String? promotionType;
  dynamic condition;

  Promotiondetail({
    this.id,
    this.promotionId,
    this.discountValue,
    this.discountPercent,
    this.description,
    this.giftProductId,
    this.giftQuantity,
    this.promotionType,
    this.condition,
  });

  factory Promotiondetail.fromJson(Map<String, dynamic> json) {
    return _$PromotiondetailFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PromotiondetailToJson(this);
}
