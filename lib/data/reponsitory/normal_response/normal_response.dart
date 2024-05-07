import 'package:json_annotation/json_annotation.dart';

import 'data_normal_response.dart';
import 'normal_error.dart';

part 'normal_response.g.dart';

@JsonSerializable()
class NormalResponse {
  int? status;
  @JsonKey(name: 'is_status')
  bool? isStatus;
  String? message;
  DataNormalResponse? data;
  @JsonKey(name: 'errors')
  NormalError? errors;

  NormalResponse(
      {this.status, this.isStatus, this.message, this.data, this.errors});

  factory NormalResponse.fromJson(Map<String, dynamic> json) {
    return _$NormalResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NormalResponseToJson(this);
}
