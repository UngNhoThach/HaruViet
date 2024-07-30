import 'package:json_annotation/json_annotation.dart';

part 'description.g.dart';

@JsonSerializable()
class Description {
  String? lang;
  String? name;

  Description({this.lang, this.name});

  factory Description.fromJson(Map<String, dynamic> json) {
    return _$DescriptionFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DescriptionToJson(this);
}
