// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataRegister _$DataRegisterFromJson(Map<String, dynamic> json) => DataRegister(
      accessToken: json['access_token'] as String?,
      tokenType: json['token_type'] as String?,
      scopes:
          (json['scopes'] as List<dynamic>?)?.map((e) => e as String).toList(),
      expiresAt: json['expires_at'] as String?,
      user: (json['user'] as List<dynamic>?)
          ?.map((e) => UserState.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataRegisterToJson(DataRegister instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'scopes': instance.scopes,
      'expires_at': instance.expiresAt,
      'user': instance.user,
    };
