import 'package:haruviet/data/reponsitory/cart_orders/models/check_order_price_response/gift_check_order_price_response.dart';
import 'package:haruviet/data/reponsitory/cart_orders/models/create_orders_response/int_or_string_converter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'attributes_get_cart_order/attributes_get_cart_order.dart';
import 'option_cart_order.dart';

part 'get_cart_order_response.g.dart';

@JsonSerializable()
class GetCartOrderResponse {
  bool? success;
  String? rowId;
  String? message;
  String? id;
  String? image;
  String? name;
  // new addition
  int? weight;
  int? totalWeight;
  List<String?>? categoryId;
  List<dynamic>? promotions;
  @JsonKey(name: 'free_shipping')
  bool? freeShipping;
  int? discount;
  GiftCheckOrderPriceResponse? gift;
// get type data int or string
  @IntOrStringConverter()
  int? qty;
  num? price;
  int? tax;
  int? storeId;
  List<OptionCartOrder?>? options;
  List<dynamic>? conditions;
  List<AttributesGetCartOrder?>? attributes;
  int? subtotal;
  num? total;
// promotions
  GetCartOrderResponse({
    this.weight,
    this.totalWeight,
    this.categoryId,
    this.promotions,
    this.freeShipping,
    this.discount,
    this.gift,
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
