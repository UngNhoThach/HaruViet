import 'package:json_annotation/json_annotation.dart';

part 'data_total.g.dart';

@JsonSerializable()
class DataTotal {
  String? title;
  String? code;
  String? value;
  String? text;
  String? sort;

  DataTotal({this.title, this.code, this.value, this.text, this.sort});

  factory DataTotal.fromJson(Map<String, dynamic> json) {
    return _$DataTotalFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DataTotalToJson(this);
}
