import 'package:json_annotation/json_annotation.dart';

part 'search_category.g.dart';

@JsonSerializable()
class SearchCategory {
  String? id;
  String? name;
  String? url;

  SearchCategory({this.id, this.name, this.url});

  factory SearchCategory.fromJson(Map<String, dynamic> json) {
    return _$SearchCategoryFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SearchCategoryToJson(this);
}
