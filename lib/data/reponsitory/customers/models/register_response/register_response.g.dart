// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    RegisterResponse(
      status: (json['status'] as num?)?.toInt(),
      isStatus: json['is_status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : DataRegister.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'is_status': instance.isStatus,
      'message': instance.message,
      'data': instance.data,
    };
