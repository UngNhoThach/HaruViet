// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataAddress _$DataAddressFromJson(Map<String, dynamic> json) => DataAddress(
      status: json['status'] as int?,
      isStatus: json['is_status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : DataListAddress.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataAddressToJson(DataAddress instance) =>
    <String, dynamic>{
      'status': instance.status,
      'is_status': instance.isStatus,
      'message': instance.message,
      'data': instance.data,
    };
