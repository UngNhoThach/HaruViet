import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

import 'tas.dart';

part 'tasfiled.g.dart';

@JsonSerializable(explicitToJson: true)
@CopyWith()
class Tasfiled {
  @JsonKey(name: 'Childs')
  List<Tas>? childs;

  Tasfiled({
    this.childs,
  });

  factory Tasfiled.fromJson(Map<String, dynamic> json) {
    return _$TasfiledFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TasfiledToJson(this);
}
