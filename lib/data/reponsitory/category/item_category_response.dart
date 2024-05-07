import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_category_response.g.dart';

@JsonSerializable()
@CopyWith()
class ItemCategoryResponse {
  @JsonKey(name: 'Id')
  int? id;
  @JsonKey(name: 'Code')
  String? code;
  @JsonKey(name: 'Name')
  String? name;

  bool isCheck;

  ItemCategoryResponse({
    this.id,
    this.code,
    this.name,
    this.isCheck = false,
  });

  factory ItemCategoryResponse.fromJson(Map<String, dynamic> json) {
    return _$ItemCategoryResponseFromJson(json);
  }

  static List<ItemCategoryResponse> fromJsonArray(
    List<dynamic> jsonArray,
  ) {
    return jsonArray
        .map(
          (dynamic e) =>
              ItemCategoryResponse.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  Map<String, dynamic> toJson() => _$ItemCategoryResponseToJson(this);
}
