// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_promotion_price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductPromotionPrice _$ProductPromotionPriceFromJson(
        Map<String, dynamic> json) =>
    ProductPromotionPrice(
      productId: json['product_id'] as String?,
      pricePromotion: json['price_promotion'] as String?,
      dateStart: json['date_start'] as String?,
      dateEnd: json['date_end'] as String?,
      statusPromotion: json['status_promotion'] as int?,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );

Map<String, dynamic> _$ProductPromotionPriceToJson(
        ProductPromotionPrice instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'price_promotion': instance.pricePromotion,
      'date_start': instance.dateStart,
      'date_end': instance.dateEnd,
      'status_promotion': instance.statusPromotion,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
