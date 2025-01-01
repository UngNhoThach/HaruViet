import 'package:haruviet/data/reponsitory/cart_orders/models/create_orders_response/int_or_string_converter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'attributes.dart';

part 'get_cart_order_response.g.dart';

@JsonSerializable()
class GetCartOrderResponse {
  bool? success;
  String? rowId;
  String? message;
  String? id;
  String? image;
  String? name;

// get type data int or string
  @IntOrStringConverter()
  int? qty;
  int? price;
  int? tax;
  int? storeId;
  List<String?>? options;
  List<dynamic>? conditions;
  AttributesGetCartOrder? attributes;
  int? subtotal;
  int? total;

  GetCartOrderResponse({
    this.rowId,
    this.image,
    this.success,
    this.message,
    this.id,
    this.name,
    this.qty,
    this.price,
    this.tax,
    this.storeId,
    this.options,
    this.conditions,
    this.attributes,
    this.subtotal,
    this.total,
  });

  factory GetCartOrderResponse.fromJson(Map<String, dynamic> json) {
    return _$GetCartOrderResponseFromJson(json);
  }

  static List<GetCartOrderResponse> fromJsonArray(
    List<dynamic> jsonArray,
  ) {
    return jsonArray
        .map(
          (dynamic e) =>
              GetCartOrderResponse.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  Map<String, dynamic> toJson() => _$GetCartOrderResponseToJson(this);
}
