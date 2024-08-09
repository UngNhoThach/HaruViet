// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_motion_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductMotionDetails _$ProductMotionDetailsFromJson(
        Map<String, dynamic> json) =>
    ProductMotionDetails(
      description: json['description'] as String?,
      promotionType: json['promotion_type'] as String?,
    );

Map<String, dynamic> _$ProductMotionDetailsToJson(
        ProductMotionDetails instance) =>
    <String, dynamic>{
      'description': instance.description,
      'promotion_type': instance.promotionType,
    };
