// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordRequest _$ResetPasswordRequestFromJson(
        Map<String, dynamic> json) =>
    ResetPasswordRequest(
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      passwordConfirmation: json['password_confirmation'] as String?,
      codeVerification: json['code_verification'] as String?,
    );

Map<String, dynamic> _$ResetPasswordRequestToJson(
        ResetPasswordRequest instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'password': instance.password,
      'password_confirmation': instance.passwordConfirmation,
      'code_verification': instance.codeVerification,
    };
