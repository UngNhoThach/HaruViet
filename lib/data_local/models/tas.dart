import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tas.g.dart';

@JsonSerializable(explicitToJson: true)
@CopyWith()
class Tas {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'startDate')
  DateTime? startDate;
  @JsonKey(name: 'isCompleted')
  bool? isCompleted;

  Tas(
      {this.id,
      this.title,
      this.description,
      this.startDate,
      this.isCompleted});

  factory Tas.fromJson(Map<String, dynamic> json) {
    return _$TasFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TasToJson(this);
}
