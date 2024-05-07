// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_exception.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiException _$ApiExceptionFromJson(Map<String, dynamic> json) => ApiException(
      statusCode: json['statusCode'] as int,
      result: json['result'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$ApiExceptionToJson(ApiException instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'result': instance.result,
      'message': instance.message,
    };
