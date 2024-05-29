import 'package:json_annotation/json_annotation.dart';

import 'data_product.dart';
import 'product_link.dart';

part 'list_product.g.dart';

@JsonSerializable()
class ListProduct {
  @JsonKey(name: 'current_page')
  int? currentPage;
  List<DataProduct>? data;
  @JsonKey(name: 'first_page_url')
  String? firstPageUrl;
  int? from;
  @JsonKey(name: 'last_page')
  int? lastPage;
  @JsonKey(name: 'last_page_url')
  String? lastPageUrl;
  List<ProductLink>? links;
  @JsonKey(name: 'next_page_url')
  String? nextPageUrl;
  String? path;
  @JsonKey(name: 'per_page')
  int? perPage;
  @JsonKey(name: 'prev_page_url')
  String? prevPageUrl;
  int? to;
  int? total;

  ListProduct({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory ListProduct.fromJson(Map<String, dynamic> json) {
    return _$ListProductFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ListProductToJson(this);
}
