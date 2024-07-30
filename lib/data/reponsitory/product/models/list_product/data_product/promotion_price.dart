import 'package:json_annotation/json_annotation.dart';

import 'price_promotion.dart';

part 'promotion_price.g.dart';

@JsonSerializable()
class PromotionPrice {
  @JsonKey(name: 'price_promotion')
  PricePromotion? pricePromotion;
  @JsonKey(name: 'date_start')
  String? dateStart;
  @JsonKey(name: 'date_end')
  String? dateEnd;
  @JsonKey(name: 'status_promotion')
  int? statusPromotion;

  PromotionPrice({
    this.pricePromotion,
    this.dateStart,
    this.dateEnd,
    this.statusPromotion,
  });

  factory PromotionPrice.fromJson(Map<String, dynamic> json) {
    return _$PromotionPriceFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PromotionPriceToJson(this);
}
