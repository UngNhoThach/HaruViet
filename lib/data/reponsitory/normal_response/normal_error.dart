import 'package:json_annotation/json_annotation.dart';

part 'normal_error.g.dart';

@JsonSerializable()
class NormalError {
  String? phone;
  String? email;

  NormalError({this.phone, this.email});

  factory NormalError.fromJson(Map<String, dynamic> json) {
    return _$NormalErrorFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NormalErrorToJson(this);
}
