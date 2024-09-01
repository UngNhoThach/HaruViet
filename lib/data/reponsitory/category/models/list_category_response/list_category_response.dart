import 'package:json_annotation/json_annotation.dart';

import 'data_category.dart';

part 'list_category_response.g.dart';

@JsonSerializable()
class ListCategoryResponse {
  @JsonKey(name: 'current_page')
  int? currentPage;
  List<DataCategory>? data;
  int? from;
  @JsonKey(name: 'last_page')
  int? lastPage;
  @JsonKey(name: 'per_page')
  int? perPage;
  int? to;
  int? total;

  ListCategoryResponse({
    this.currentPage,
    this.data,
    this.from,
    this.lastPage,
    this.perPage,
    this.to,
    this.total,
  });

  factory ListCategoryResponse.fromJson(Map<String, dynamic> json) {
    return _$ListCategoryResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ListCategoryResponseToJson(this);
}
