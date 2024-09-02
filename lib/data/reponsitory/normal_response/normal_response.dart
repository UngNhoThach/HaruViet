import 'package:json_annotation/json_annotation.dart';

import 'customer_response/data_normal_response.dart';
import 'data_review_response/data_review_response.dart';
import 'customer_response/normal_error.dart';

part 'normal_response.g.dart';

@JsonSerializable()
class NormalResponse {
  int? status;
  @JsonKey(name: 'is_status')
  bool? isStatus;
  @JsonKey(name: 'success')
  bool? success;
  String? message;
  dynamic data;

//  DataNormalResponse? data;
  @JsonKey(name: 'errors')
  NormalError? errors;

  NormalResponse(
      {this.status,
      this.isStatus,
      this.message,
      this.data,
      this.errors,
      this.success});

  factory NormalResponse.fromJson(Map<String, dynamic> json) {
    return _$NormalResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NormalResponseToJson(this);

  // Method to parse `data` as DataNormalResponse
  DataNormalResponse? parseDataNormalData() {
    if (data is Map<String, dynamic>) {
      return DataNormalResponse.fromJson(data);
    }
    return null;
  }

  // Method to parse `data` as DataReviewResponse
  DataReviewResponse? parseReviewData() {
    if (data is Map<String, dynamic>) {
      return DataReviewResponse.fromJson(data);
    }
    return null;
  }
}
