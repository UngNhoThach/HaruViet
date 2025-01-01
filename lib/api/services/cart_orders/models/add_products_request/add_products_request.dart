import 'package:json_annotation/json_annotation.dart';

import 'options_add_products_request.dart';

part 'add_products_request.g.dart';

@JsonSerializable()
class AddProductsRequest {
  @JsonKey(name: 'product_id')
  String? productId;
  int? qty;
  OptionsAddProductsRequest? options;

  AddProductsRequest({this.productId, this.qty, this.options});

  factory AddProductsRequest.fromJson(Map<String, dynamic> json) =>
      _$AddProductsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddProductsRequestToJson(this);
}
