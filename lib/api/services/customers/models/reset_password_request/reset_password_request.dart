import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request.g.dart';

@JsonSerializable()
class ResetPasswordRequest {
  String? phone;
  String? password;
  @JsonKey(name: 'password_confirmation')
  String? passwordConfirmation;
  @JsonKey(name: 'code_verification')
  String? codeVerification;

  ResetPasswordRequest({
    this.phone,
    this.password,
    this.passwordConfirmation,
    this.codeVerification,
  });

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) {
    return _$ResetPasswordRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);
}
