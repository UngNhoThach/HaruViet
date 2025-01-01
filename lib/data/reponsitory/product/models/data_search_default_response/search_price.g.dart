// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchPrice _$SearchPriceFromJson(Map<String, dynamic> json) => SearchPrice(
      searchpriceStr: json['price_str'] as String?,
      finalSearchPriceStr: json['final_price_str'] as String?,
      promotionPercent: (json['promotion_percent'] as num?)?.toInt(),
      price: json['price'] as String?,
    );

Map<String, dynamic> _$SearchPriceToJson(SearchPrice instance) =>
    <String, dynamic>{
      'price_str': instance.searchpriceStr,
      'final_price_str': instance.finalSearchPriceStr,
      'promotion_percent': instance.promotionPercent,
      'price': instance.price,
    };
