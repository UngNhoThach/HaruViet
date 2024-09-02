import 'package:json_annotation/json_annotation.dart';

import 'data_customer.dart';

part 'get_info_user_response.g.dart';

@JsonSerializable()
class GetInfoUserResponse {
  int? status;
  @JsonKey(name: 'is_status')
  bool? isStatus;
  String? message;
  DataCustomer? data;

  GetInfoUserResponse({
    this.status,
    this.isStatus,
    this.message,
    this.data,
  });

  factory GetInfoUserResponse.fromJson(Map<String, dynamic> json) {
    return _$GetInfoUserResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetInfoUserResponseToJson(this);
}
