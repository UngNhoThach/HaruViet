// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipment_fee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShipmentFee _$ShipmentFeeFromJson(Map<String, dynamic> json) => ShipmentFee(
      name: json['name'] as String?,
      fee: (json['fee'] as num?)?.toInt(),
      insuranceFee: (json['insurance_fee'] as num?)?.toInt(),
      includeVat: (json['include_vat'] as num?)?.toInt(),
      costId: (json['cost_id'] as num?)?.toInt(),
      deliveryType: json['delivery_type'] as String?,
      a: (json['a'] as num?)?.toInt(),
      dt: json['dt'] as String?,
      extFees: (json['extFees'] as List<dynamic>?)
          ?.map((e) => ShipmentExtFee.fromJson(e as Map<String, dynamic>))
          .toList(),
      promotionKey: json['promotion_key'] as String?,
      delivery: json['delivery'] as bool?,
      shipFeeOnly: (json['ship_fee_only'] as num?)?.toInt(),
      distance: (json['distance'] as num?)?.toDouble(),
      options: json['options'] == null
          ? null
          : ShipmentOptions.fromJson(json['options'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShipmentFeeToJson(ShipmentFee instance) =>
    <String, dynamic>{
      'name': instance.name,
      'fee': instance.fee,
      'insurance_fee': instance.insuranceFee,
      'include_vat': instance.includeVat,
      'cost_id': instance.costId,
      'delivery_type': instance.deliveryType,
      'a': instance.a,
      'dt': instance.dt,
      'extFees': instance.extFees,
      'promotion_key': instance.promotionKey,
      'delivery': instance.delivery,
      'ship_fee_only': instance.shipFeeOnly,
      'distance': instance.distance,
      'options': instance.options,
    };
