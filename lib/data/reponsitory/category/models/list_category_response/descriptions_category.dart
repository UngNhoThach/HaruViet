import 'package:json_annotation/json_annotation.dart';

part 'descriptions_category.g.dart';

@JsonSerializable()
class DescriptionsCategory {
  @JsonKey(name: 'category_id')
  String? categoryId;
  String? lang;
  String? title;
  dynamic keyword;
  dynamic description;

  DescriptionsCategory({
    this.categoryId,
    this.lang,
    this.title,
    this.keyword,
    this.description,
  });

  factory DescriptionsCategory.fromJson(Map<String, dynamic> json) {
    return _$DescriptionsCategoryFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DescriptionsCategoryToJson(this);
}
