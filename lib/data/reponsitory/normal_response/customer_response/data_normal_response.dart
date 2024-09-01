import 'package:json_annotation/json_annotation.dart';

part 'data_normal_response.g.dart';

@JsonSerializable()
class DataNormalResponse {
  int? timeout;

  DataNormalResponse({this.timeout});

  factory DataNormalResponse.fromJson(Map<String, dynamic> json) =>
      _$DataNormalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataNormalResponseToJson(this);
}
