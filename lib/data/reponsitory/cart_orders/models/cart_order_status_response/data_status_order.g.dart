// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_status_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataStatusOrder _$DataStatusOrderFromJson(Map<String, dynamic> json) =>
    DataStatusOrder(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$DataStatusOrderToJson(DataStatusOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
