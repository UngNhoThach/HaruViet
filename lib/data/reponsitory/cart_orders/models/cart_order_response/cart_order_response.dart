import 'package:json_annotation/json_annotation.dart';

import 'data_cart_response.dart';

part 'cart_order_response.g.dart';

@JsonSerializable()
class CartOrderResponse {
  @JsonKey(name: 'current_page')
  int? currentPage;
  List<DataCart>? data;
  int? from;
  @JsonKey(name: 'last_page')
  int? lastPage;
  @JsonKey(name: 'per_page')
  int? perPage;
  int? to;
  int? total;

  CartOrderResponse({
    this.currentPage,
    this.data,
    this.from,
    this.lastPage,
    this.perPage,
    this.to,
    this.total,
  });

  factory CartOrderResponse.fromJson(Map<String, dynamic> json) {
    return _$CartOrderResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CartOrderResponseToJson(this);
}
