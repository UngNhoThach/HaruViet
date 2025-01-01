import 'package:json_annotation/json_annotation.dart';

import 'data_register.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  int? status;
  @JsonKey(name: 'is_status')
  bool? isStatus;
  String? message;
  DataRegister? data;

  RegisterResponse({this.status, this.isStatus, this.message, this.data});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return _$RegisterResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
