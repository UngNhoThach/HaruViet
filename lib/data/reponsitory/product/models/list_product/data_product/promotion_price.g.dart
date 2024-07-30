// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionPrice _$PromotionPriceFromJson(Map<String, dynamic> json) =>
    PromotionPrice(
      pricePromotion: json['price_promotion'] == null
          ? null
          : PricePromotion.fromJson(
              json['price_promotion'] as Map<String, dynamic>),
      dateStart: json['date_start'] as String?,
      dateEnd: json['date_end'] as String?,
      statusPromotion: json['status_promotion'] as int?,
    );

Map<String, dynamic> _$PromotionPriceToJson(PromotionPrice instance) =>
    <String, dynamic>{
      'price_promotion': instance.pricePromotion,
      'date_start': instance.dateStart,
      'date_end': instance.dateEnd,
      'status_promotion': instance.statusPromotion,
    };
