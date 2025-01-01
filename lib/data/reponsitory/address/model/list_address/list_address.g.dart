// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListAddress _$ListAddressFromJson(Map<String, dynamic> json) => ListAddress(
      status: (json['status'] as num?)?.toInt(),
      isStatus: json['is_status'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataListAddress.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListAddressToJson(ListAddress instance) =>
    <String, dynamic>{
      'status': instance.status,
      'is_status': instance.isStatus,
      'message': instance.message,
      'data': instance.data,
    };
