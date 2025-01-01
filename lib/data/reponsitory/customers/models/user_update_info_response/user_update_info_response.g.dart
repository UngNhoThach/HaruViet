// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_update_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserUpdateInfoResponse _$UserUpdateInfoResponseFromJson(
        Map<String, dynamic> json) =>
    UserUpdateInfoResponse(
      status: (json['status'] as num?)?.toInt(),
      isStatus: json['is_status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : UserState.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserUpdateInfoResponseToJson(
        UserUpdateInfoResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'is_status': instance.isStatus,
      'message': instance.message,
      'data': instance.data,
    };
