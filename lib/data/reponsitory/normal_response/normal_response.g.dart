// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'normal_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NormalResponse _$NormalResponseFromJson(Map<String, dynamic> json) =>
    NormalResponse(
      status: (json['status'] as num?)?.toInt(),
      isStatus: json['is_status'] as bool?,
      message: json['message'] as String?,
      data: json['data'],
      errors: json['errors'] == null
          ? null
          : NormalError.fromJson(json['errors'] as Map<String, dynamic>),
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$NormalResponseToJson(NormalResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'is_status': instance.isStatus,
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
      'errors': instance.errors,
    };
