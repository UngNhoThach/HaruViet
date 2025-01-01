import 'package:json_annotation/json_annotation.dart';

part 'options_add_products_request.g.dart';

@JsonSerializable()
class OptionsAddProductsRequest {
  List<Map<String, dynamic>>? options;

  OptionsAddProductsRequest({this.options});

  factory OptionsAddProductsRequest.fromJson(Map<String, dynamic> json) {
    return _$OptionsAddProductsRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OptionsAddProductsRequestToJson(this);
}
