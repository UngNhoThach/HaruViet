import 'package:json_annotation/json_annotation.dart';

part 'get_list_product_request.g.dart';

@JsonSerializable()
class GetListProductRequest {
  @JsonKey(name: 'page[number]')
  int paegNumber;
  @JsonKey(name: 'page[size]')
  int pageSize;
  @JsonKey(name: 'sort')
  String? sort;
  @JsonKey(name: 'lang')
  String? language;
  @JsonKey(name: 'category')
  String? category;
  Map<String, String>? filters;

  GetListProductRequest({
    required this.paegNumber,
    required this.pageSize,
    this.sort,
    this.language,
    this.category,
    this.filters,
  });

  // Map<String, dynamic> toJson() => _$GetListProductRequestToJson(this);

  Map<String, dynamic> toJson() {
    final data = _$GetListProductRequestToJson(this);

    // Add dynamic filters to the JSON map
    if (filters != null) {
      for (var entry in filters!.entries) {
        data['filter-${entry.key}'] = entry.value;
      }
    }

    return data;
  }
}
