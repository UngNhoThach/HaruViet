import 'package:haruviet/data/data_local/user_state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_register.g.dart';

@JsonSerializable()
class DataRegister {
  @JsonKey(name: 'access_token')
  String? accessToken;
  @JsonKey(name: 'token_type')
  String? tokenType;
  List<String>? scopes;
  @JsonKey(name: 'expires_at')
  String? expiresAt;
  List<UserState>? user;

  DataRegister({
    this.accessToken,
    this.tokenType,
    this.scopes,
    this.expiresAt,
    this.user,
  });

  factory DataRegister.fromJson(Map<String, dynamic> json) =>
      _$DataRegisterFromJson(json);

  Map<String, dynamic> toJson() => _$DataRegisterToJson(this);
}
