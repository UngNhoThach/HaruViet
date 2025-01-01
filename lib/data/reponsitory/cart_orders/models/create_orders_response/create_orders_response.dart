import 'package:json_annotation/json_annotation.dart';

import 'detail_create_orders.dart';

part 'create_orders_response.g.dart';

@JsonSerializable()
class CreateOrdersResponse {
  int? error;
  @JsonKey(name: 'orderID')
  String? orderId;
  String? msg;
  DetailCreateOrders? detail;

  CreateOrdersResponse({this.error, this.orderId, this.msg, this.detail});

  factory CreateOrdersResponse.fromJson(Map<String, dynamic> json) {
    return _$CreateOrdersResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreateOrdersResponseToJson(this);
}
