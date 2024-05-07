import 'package:json_annotation/json_annotation.dart';

import 'user_login.dart';

part 'data_login.g.dart';

@JsonSerializable()
class DataLogin {
  @JsonKey(name: 'access_token')
  String? accessToken;
  @JsonKey(name: 'token_type')
  String? tokenType;
  List<String>? scopes;
  @JsonKey(name: 'expires_at')
  String? expiresAt;
  UserLogin? user;

  DataLogin({
    this.accessToken,
    this.tokenType,
    this.scopes,
    this.expiresAt,
    this.user,
  });

  factory DataLogin.fromJson(Map<String, dynamic> json) =>
      _$DataLoginFromJson(json);

  Map<String, dynamic> toJson() => _$DataLoginToJson(this);
}
