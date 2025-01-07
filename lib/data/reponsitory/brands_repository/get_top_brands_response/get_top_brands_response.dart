import 'package:json_annotation/json_annotation.dart';

import 'data_top_brand.dart';

part 'get_top_brands_response.g.dart';

@JsonSerializable()
class GetTopBrandsResponse {
  @JsonKey(name: 'current_page')
  int? currentPage;
  List<DataTopBrand>? data;
  int? from;
  @JsonKey(name: 'last_page')
  int? lastPage;
  @JsonKey(name: 'per_page')
  int? perPage;
  int? to;
  int? total;

  GetTopBrandsResponse({
    this.currentPage,
    this.data,
    this.from,
    this.lastPage,
    this.perPage,
    this.to,
    this.total,
  });

  factory GetTopBrandsResponse.fromJson(Map<String, dynamic> json) {
    return _$GetTopBrandsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetTopBrandsResponseToJson(this);
}
