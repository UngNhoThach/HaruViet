import 'package:json_annotation/json_annotation.dart';

import 'price_promotion_list.dart';

part 'product_promotion_price_list.g.dart';

@JsonSerializable()
class ProductPromotionPriceList {
  @JsonKey(name: 'price_promotion')
  PricePromotion? pricePromotion;
  @JsonKey(name: 'date_start')
  String? dateStart;
  @JsonKey(name: 'date_end')
  String? dateEnd;
  @JsonKey(name: 'percent')
  double? percent;

  ProductPromotionPriceList({
    this.pricePromotion,
    this.dateStart,
    this.percent,
    this.dateEnd,
  });

  factory ProductPromotionPriceList.fromJson(Map<String, dynamic> json) {
    return _$ProductPromotionPriceListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductPromotionPriceListToJson(this);
}
