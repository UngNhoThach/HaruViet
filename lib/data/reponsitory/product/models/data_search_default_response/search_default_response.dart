import 'package:json_annotation/json_annotation.dart';

import 'search_category.dart';
import 'search_product.dart';

part 'search_default_response.g.dart';

@JsonSerializable()
class SearchDefaultResponse {
  List<SearchCategory>? categories;
  List<SearchProduct>? products;
  int? remaining;

  SearchDefaultResponse({this.categories, this.products, this.remaining});

  factory SearchDefaultResponse.fromJson(Map<String, dynamic> json) {
    return _$SearchDefaultResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SearchDefaultResponseToJson(this);
}
