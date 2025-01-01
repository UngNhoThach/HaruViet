// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_order_price_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckOrderPriceResponse _$CheckOrderPriceResponseFromJson(
        Map<String, dynamic> json) =>
    CheckOrderPriceResponse(
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
      productId: json['product_id'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
      attribute: json['attribute'] == null
          ? null
          : AttributeCheckPrice.fromJson(
              json['attribute'] as Map<String, dynamic>),
      price: json['price'],
      totalPrice: (json['total_price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CheckOrderPriceResponseToJson(
        CheckOrderPriceResponse instance) =>
    <String, dynamic>{
      'promotions': instance.promotions,
      'free_shipping': instance.freeShipping,
      'discount_detail': instance.discountDetail,
      'discount_order': instance.discountOrder,
      'gift': instance.gift,
      'product_id': instance.productId,
      'qty': instance.qty,
      'attribute': instance.attribute,
      'price': instance.price,
      'total_price': instance.totalPrice,
    };
