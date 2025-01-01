import 'package:json_annotation/json_annotation.dart';

import 'data_order.dart';
import 'data_total.dart';
import 'item_detail.dart';

part 'create_order_request.g.dart';

@JsonSerializable()
class CreateOrderRequest {
  DataOrder? dataOrder;
  List<DataTotal>? dataTotal;
  List<ItemDetail>? itemDetail;

  CreateOrderRequest({this.dataOrder, this.dataTotal, this.itemDetail});

  factory CreateOrderRequest.fromJson(Map<String, dynamic> json) {
    return _$CreateOrderRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreateOrderRequestToJson(this);
}
