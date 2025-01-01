// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'respone_general.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralResponse _$GeneralResponseFromJson(Map<String, dynamic> json) =>
    GeneralResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      currentPage: (json['current_page'] as num?)?.toInt(),
      data: json['data'] as List<dynamic>?,
      from: (json['from'] as num?)?.toInt(),
      path: json['path'] as String?,
      lastPage: (json['last_page'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
      to: (json['to'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GeneralResponseToJson(GeneralResponse instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'from': instance.from,
      'last_page': instance.lastPage,
      'path': instance.path,
      'success': instance.success,
      'message': instance.message,
      'per_page': instance.perPage,
      'to': instance.to,
      'total': instance.total,
      'data': instance.data,
    };
