import 'package:json_annotation/json_annotation.dart';

import 'data_login.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  int? status;
  @JsonKey(name: 'is_status')
  bool? isStatus;
  String? message;
  DataLogin? data;

  LoginResponse({this.status, this.isStatus, this.message, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return _$LoginResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
