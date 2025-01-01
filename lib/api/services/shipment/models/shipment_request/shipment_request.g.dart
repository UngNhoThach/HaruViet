// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShipmentRequest _$ShipmentRequestFromJson(Map<String, dynamic> json) =>
    ShipmentRequest(
      pickAddressId: json['pick_address_id'] as String?,
      pickAddress: json['pick_address'] as String?,
      pickWard: json['pick_ward'] as String?,
      pickStreet: json['pick_street'] as String?,
      ward: json['ward'] as String?,
      street: json['street'] as String?,
      pickProvince: json['pick_province'] as String?,
      pickDistrict: json['pick_district'] as String?,
      province: json['province'] as String?,
      district: json['district'] as String?,
      address: json['address'] as String?,
      weight: (json['weight'] as num?)?.toInt(),
      value: (json['value'] as num?)?.toInt(),
      transport: json['transport'] as String?,
      deliverOption: json['deliver_option'] as String?,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$ShipmentRequestToJson(ShipmentRequest instance) =>
    <String, dynamic>{
      'pick_address_id': instance.pickAddressId,
      'pick_address': instance.pickAddress,
      'pick_ward': instance.pickWard,
      'pick_street': instance.pickStreet,
      'ward': instance.ward,
      'street': instance.street,
      'pick_province': instance.pickProvince,
      'pick_district': instance.pickDistrict,
      'province': instance.province,
      'district': instance.district,
      'address': instance.address,
      'weight': instance.weight,
      'value': instance.value,
      'transport': instance.transport,
      'deliver_option': instance.deliverOption,
      'tags': instance.tags,
    };
