// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_password_phone_number_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePasswordPhoneNumberRequest _$UpdatePasswordPhoneNumberRequestFromJson(
        Map<String, dynamic> json) =>
    UpdatePasswordPhoneNumberRequest(
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      passwordConfirmation: json['password_confirmation'] as String?,
      codeVerification: json['code_verification'] as String?,
    );

Map<String, dynamic> _$UpdatePasswordPhoneNumberRequestToJson(
        UpdatePasswordPhoneNumberRequest instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'password': instance.password,
      'password_confirmation': instance.passwordConfirmation,
      'code_verification': instance.codeVerification,
    };
