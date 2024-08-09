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

  GetListProductRequest({
    required this.paegNumber,
    required this.pageSize,
    this.sort,
    this.language,
  });

  Map<String, dynamic> toJson() => _$GetListProductRequestToJson(this);
}
