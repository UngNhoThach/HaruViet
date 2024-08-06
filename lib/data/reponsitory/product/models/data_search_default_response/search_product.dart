import 'package:json_annotation/json_annotation.dart';

import 'search_price.dart';

part 'search_product.g.dart';

@JsonSerializable()
class SearchProduct {
  String? id;
  @JsonKey(name: 'name_found')
  String? nameFound;
  String? name;
  SearchPrice? price;
  String? image;
  @JsonKey(name: 'is_out_of_stock')
  int? isOutOfStock;
  String? url;

  SearchProduct({
    this.id,
    this.nameFound,
    this.name,
    this.price,
    this.image,
    this.isOutOfStock,
    this.url,
  });

  factory SearchProduct.fromJson(Map<String, dynamic> json) {
    return _$SearchProductFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SearchProductToJson(this);
}
