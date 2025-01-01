// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      price: (json['price'] as num?)?.toInt(),
      priceStr: json['price_str'] as String?,
      exchangeRate: (json['exchange_rate'] as num?)?.toInt(),
      totalPriceItem: (json['totalPriceItem'] as num?)?.toInt(),
      totalQuantity: (json['totalQuantity'] as num?)?.toInt(),
      currency: json['currency'] as String?,
      discountOrder: (json['discountOrder'] as num?)?.toInt(),
      discountDetail: json['discountDetail'] as num?,
    );

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'price': instance.price,
      'price_str': instance.priceStr,
      'discountDetail': instance.discountDetail,
      'exchange_rate': instance.exchangeRate,
      'totalPriceItem': instance.totalPriceItem,
      'currency': instance.currency,
      'discountOrder': instance.discountOrder,
      'totalQuantity': instance.totalQuantity,
    };
