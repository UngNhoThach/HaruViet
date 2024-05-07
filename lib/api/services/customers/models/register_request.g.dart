// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      username: json['username'] as String?,
      firstName: json['first_name'] as String?,
      password: json['password'] as String?,
      passwordConfirmation: json['password_confirmation'] as String?,
      codeVerification: json['code_verification'] as String?,
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'first_name': instance.firstName,
      'password': instance.password,
      'password_confirmation': instance.passwordConfirmation,
      'code_verification': instance.codeVerification,
    };
