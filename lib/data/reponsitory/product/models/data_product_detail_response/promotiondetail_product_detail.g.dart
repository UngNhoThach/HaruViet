// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotiondetail_product_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Promotiondetail _$PromotiondetailFromJson(Map<String, dynamic> json) =>
    Promotiondetail(
      id: json['id'] as String?,
      promotionId: json['promotion_id'] as String?,
      discountValue: json['discount_value'],
      discountPercent: json['discount_percent'] as String?,
      description: json['description'] as String?,
      giftProductId: json['gift_product_id'],
      giftQuantity: json['gift_quantity'],
      promotionType: json['promotion_type'] as String?,
      condition: json['condition'],
    );

Map<String, dynamic> _$PromotiondetailToJson(Promotiondetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'promotion_id': instance.promotionId,
      'discount_value': instance.discountValue,
      'discount_percent': instance.discountPercent,
      'description': instance.description,
      'gift_product_id': instance.giftProductId,
      'gift_quantity': instance.giftQuantity,
      'promotion_type': instance.promotionType,
      'condition': instance.condition,
    };
