// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttributesGetCartOrder _$AttributesGetCartOrderFromJson(
        Map<String, dynamic> json) =>
    AttributesGetCartOrder(
      promotions: (json['promotions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      freeShipping: json['free_shipping'] as bool?,
      discountDetail: (json['discount_detail'] as num?)?.toInt(),
      discountOrder: (json['discount_order'] as num?)?.toInt(),
      gift: json['gift'] == null
          ? null
          : GiftCheckOrderPriceResponse.fromJson(
              json['gift'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AttributesGetCartOrderToJson(
        AttributesGetCartOrder instance) =>
    <String, dynamic>{
      'promotions': instance.promotions,
      'free_shipping': instance.freeShipping,
      'discount_detail': instance.discountDetail,
      'discount_order': instance.discountOrder,
      'gift': instance.gift,
    };
