// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipment_ext_fee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShipmentExtFee _$ShipmentExtFeeFromJson(Map<String, dynamic> json) =>
    ShipmentExtFee(
      display: json['display'] as String?,
      title: json['title'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
      type: json['type'] as String?,
      tagId: (json['tag_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ShipmentExtFeeToJson(ShipmentExtFee instance) =>
    <String, dynamic>{
      'display': instance.display,
      'title': instance.title,
      'amount': instance.amount,
      'type': instance.type,
      'tag_id': instance.tagId,
    };
