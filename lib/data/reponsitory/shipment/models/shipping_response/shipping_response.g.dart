// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipping_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShippingResponse _$ShippingResponseFromJson(Map<String, dynamic> json) =>
    ShippingResponse(
      shippingStandard: json['ShippingStandard'] == null
          ? null
          : ShippingStandard.fromJson(
              json['ShippingStandard'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShippingResponseToJson(ShippingResponse instance) =>
    <String, dynamic>{
      'ShippingStandard': instance.shippingStandard,
    };
