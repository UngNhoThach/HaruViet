// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'normal_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NormalResponse _$NormalResponseFromJson(Map<String, dynamic> json) =>
    NormalResponse(
      status: json['status'] as int?,
      isStatus: json['is_status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : DataNormalResponse.fromJson(json['data'] as Map<String, dynamic>),
      errors: json['errors'] == null
          ? null
          : NormalError.fromJson(json['errors'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NormalResponseToJson(NormalResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'is_status': instance.isStatus,
      'message': instance.message,
      'data': instance.data,
      'errors': instance.errors,
    };
