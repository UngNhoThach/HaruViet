import 'package:json_annotation/json_annotation.dart';

import 'values.dart';

part 'option.g.dart';

@JsonSerializable()
class Option {
  String? name;
  Values? values;

  Option({this.name, this.values});

  factory Option.fromJson(Map<String, dynamic> json) {
    return _$OptionFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OptionToJson(this);
}
