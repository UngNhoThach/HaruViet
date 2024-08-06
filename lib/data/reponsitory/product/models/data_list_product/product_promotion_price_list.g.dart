// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_promotion_price_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductPromotionPriceList _$ProductPromotionPriceListFromJson(
        Map<String, dynamic> json) =>
    ProductPromotionPriceList(
      pricePromotion: json['price_promotion'] == null
          ? null
          : PricePromotion.fromJson(
              json['price_promotion'] as Map<String, dynamic>),
      dateStart: json['date_start'] as String?,
      percent: (json['percent'] as num?)?.toDouble(),
      dateEnd: json['date_end'] as String?,
    );

Map<String, dynamic> _$ProductPromotionPriceListToJson(
        ProductPromotionPriceList instance) =>
    <String, dynamic>{
      'price_promotion': instance.pricePromotion,
      'date_start': instance.dateStart,
      'date_end': instance.dateEnd,
      'percent': instance.percent,
    };
