// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataLogin _$DataLoginFromJson(Map<String, dynamic> json) => DataLogin(
      accessToken: json['access_token'] as String?,
      tokenType: json['token_type'] as String?,
      scopes:
          (json['scopes'] as List<dynamic>?)?.map((e) => e as String).toList(),
      expiresAt: json['expires_at'] as String?,
      user: json['user'] == null
          ? null
          : UserState.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataLoginToJson(DataLogin instance) => <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'scopes': instance.scopes,
      'expires_at': instance.expiresAt,
      'user': instance.user,
    };
