import 'package:json_annotation/json_annotation.dart';

part 'price_promotion_list.g.dart';

@JsonSerializable()
class PricePromotion {
  int? price;
  @JsonKey(name: 'price_str')
  String? priceStr;
  @JsonKey(name: 'exchange_rate')
  int? exchangeRate;
  String? currency;

  PricePromotion({
    this.price,
    this.priceStr,
    this.exchangeRate,
    this.currency,
  });

  factory PricePromotion.fromJson(Map<String, dynamic> json) {
    return _$PricePromotionFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PricePromotionToJson(this);
}
