import 'package:json_annotation/json_annotation.dart';

import 'data_user_update_info.dart';

part 'user_update_info_response.g.dart';

@JsonSerializable()
class UserUpdateInfoResponse {
  int? status;
  @JsonKey(name: 'is_status')
  bool? isStatus;
  String? message;
  DataUserUpdateInfo? data;

  UserUpdateInfoResponse({
    this.status,
    this.isStatus,
    this.message,
    this.data,
  });

  factory UserUpdateInfoResponse.fromJson(Map<String, dynamic> json) {
    return _$UserUpdateInfoResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserUpdateInfoResponseToJson(this);
}
