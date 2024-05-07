import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  @JsonKey(name: 'username')
  String? username;
  @JsonKey(name: 'first_name')
  String? firstName;
  @JsonKey(name: 'password')
  String? password;
  @JsonKey(name: 'password_confirmation')
  String? passwordConfirmation;
  @JsonKey(name: 'code_verification')
  String? codeVerification;
  RegisterRequest({
    this.username,
    this.firstName,
    this.password,
    this.passwordConfirmation,
    this.codeVerification,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return _$RegisterRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
