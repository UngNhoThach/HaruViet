// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift_check_order_price_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiftCheckOrderPriceResponse _$GiftCheckOrderPriceResponseFromJson(
        Map<String, dynamic> json) =>
    GiftCheckOrderPriceResponse(
      giftId: json['gift_id'] as String?,
      giftType: json['gift_type'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GiftCheckOrderPriceResponseToJson(
        GiftCheckOrderPriceResponse instance) =>
    <String, dynamic>{
      'gift_id': instance.giftId,
      'gift_type': instance.giftType,
      'quantity': instance.quantity,
    };
