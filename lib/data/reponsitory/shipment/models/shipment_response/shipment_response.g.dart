// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShipmentResponse _$ShipmentResponseFromJson(Map<String, dynamic> json) =>
    ShipmentResponse(
      success: json['success'] as bool?,
      fee: json['fee'] == null
          ? null
          : ShipmentFee.fromJson(json['fee'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ShipmentResponseToJson(ShipmentResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'fee': instance.fee,
      'message': instance.message,
    };
