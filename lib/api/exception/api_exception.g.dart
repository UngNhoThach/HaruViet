// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_exception.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiException _$ApiExceptionFromJson(Map<String, dynamic> json) => ApiException(
      statusCode: (json['statusCode'] as num).toInt(),
      result: (json['result'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$ApiExceptionToJson(ApiException instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'result': instance.result,
      'message': instance.message,
    };
