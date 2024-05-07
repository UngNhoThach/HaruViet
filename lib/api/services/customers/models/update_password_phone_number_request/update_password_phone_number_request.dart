import 'package:json_annotation/json_annotation.dart';

part 'update_password_phone_number_request.g.dart';

@JsonSerializable()
class UpdatePasswordPhoneNumberRequest {
  String? phone;
  String? password;
  @JsonKey(name: 'password_confirmation')
  String? passwordConfirmation;
  @JsonKey(name: 'code_verification')
  String? codeVerification;

  UpdatePasswordPhoneNumberRequest({
    this.phone,
    this.password,
    this.passwordConfirmation,
    this.codeVerification,
  });

  factory UpdatePasswordPhoneNumberRequest.fromJson(Map<String, dynamic> json) {
    return _$UpdatePasswordPhoneNumberRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UpdatePasswordPhoneNumberRequestToJson(this);
  }
}
