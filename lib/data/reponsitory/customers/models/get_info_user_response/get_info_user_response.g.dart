// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_info_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetInfoUserResponse _$GetInfoUserResponseFromJson(Map<String, dynamic> json) =>
    GetInfoUserResponse(
      status: (json['status'] as num?)?.toInt(),
      isStatus: json['is_status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : DataCustomer.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetInfoUserResponseToJson(
        GetInfoUserResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'is_status': instance.isStatus,
      'message': instance.message,
      'data': instance.data,
    };
