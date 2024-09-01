import 'package:json_annotation/json_annotation.dart';
import 'data_product_list.dart';

part 'list_product.g.dart';

@JsonSerializable()
class ListProduct {
  @JsonKey(name: 'current_page')
  int? currentPage;
  @JsonKey(name: 'data')
  List<DataProduct>? data;
  int? from;
  @JsonKey(name: 'last_page')
  int? lastPage;
  String? path;
  @JsonKey(name: 'per_page')
  int? perPage;
  int? to;
  int? total;

  ListProduct({
    this.currentPage,
    this.data,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory ListProduct.fromJson(Map<String, dynamic> json) {
    return _$ListProductFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ListProductToJson(this);
}
