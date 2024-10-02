import 'package:json_annotation/json_annotation.dart';

import 'cart_check_price.dart';

part 'check_order_price_request.g.dart';

@JsonSerializable()
class CheckOrderPriceRequest {
  String? paymentMethod;
  String? customerUsageCount;
  String? customerType;
  String? inputCoupon;
  List<CartCheckPrice>? cart;

  CheckOrderPriceRequest({
    this.paymentMethod,
    this.customerUsageCount,
    this.customerType,
    this.inputCoupon,
    this.cart,
  });

  factory CheckOrderPriceRequest.fromJson(Map<String, dynamic> json) {
    return _$CheckOrderPriceRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CheckOrderPriceRequestToJson(this);
}
