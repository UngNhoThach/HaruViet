import 'package:json_annotation/json_annotation.dart';

part 'descriptions_attributes.g.dart';

@JsonSerializable()
class AtributesDescriptions {
  @JsonKey(name: 'attributes_id')
  String? attributesId;
  String? lang;
  String? title;

  AtributesDescriptions({this.attributesId, this.lang, this.title});

  factory AtributesDescriptions.fromJson(Map<String, dynamic> json) {
    return _$AtributesDescriptionsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AtributesDescriptionsToJson(this);
}
