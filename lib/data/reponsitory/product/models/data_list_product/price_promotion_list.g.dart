// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_promotion_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PricePromotion _$PricePromotionFromJson(Map<String, dynamic> json) =>
    PricePromotion(
      price: json['price'] as int?,
      priceStr: json['price_str'] as String?,
      exchangeRate: json['exchange_rate'] as int?,
      currency: json['currency'] as String?,
    );

Map<String, dynamic> _$PricePromotionToJson(PricePromotion instance) =>
    <String, dynamic>{
      'price': instance.price,
      'price_str': instance.priceStr,
      'exchange_rate': instance.exchangeRate,
      'currency': instance.currency,
    };
