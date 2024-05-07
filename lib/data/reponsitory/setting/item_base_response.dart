import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_base_response.g.dart';

@JsonSerializable(explicitToJson: true)
@CopyWith()
class ItemBaseResponse {
  @JsonKey(name: 'Id')
  int? id;
  @JsonKey(name: 'Type')
  int? type;
  @JsonKey(name: 'Code')
  String? code;
  @JsonKey(name: 'Name')
  String? name;

  ItemBaseResponse({
    this.id,
    this.type,
    this.code,
    this.name,
  });

  factory ItemBaseResponse.fromJson(Map<String, dynamic> json) {
    return _$ItemBaseResponseFromJson(json);
  }

  static List<ItemBaseResponse> fromJsonArray(
    List<dynamic> jsonArray,
  ) {
    return jsonArray
        .map(
          (dynamic e) => ItemBaseResponse.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  Map<String, dynamic> toJson() => _$ItemBaseResponseToJson(this);
}
