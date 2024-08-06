import 'package:json_annotation/json_annotation.dart';

part 'product_promotion_price.g.dart';

@JsonSerializable()
class ProductPromotionPrice {
  @JsonKey(name: 'product_id')
  String? productId;
  @JsonKey(name: 'price_promotion')
  String? pricePromotion;
  @JsonKey(name: 'date_start')
  String? dateStart;
  @JsonKey(name: 'date_end')
  String? dateEnd;
  @JsonKey(name: 'status_promotion')
  int? statusPromotion;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'percent')
  double? percent;

  ProductPromotionPrice({
    this.productId,
    this.pricePromotion,
    this.dateStart,
    this.percent,
    this.dateEnd,
    this.statusPromotion,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductPromotionPrice.fromJson(Map<String, dynamic> json) {
    return _$ProductPromotionPriceFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductPromotionPriceToJson(this);
}
