import 'package:json_annotation/json_annotation.dart';

import 'details_cart.dart';

part 'data_cart_response.g.dart';

@JsonSerializable()
class DataCart {
  String? id;
  @JsonKey(name: 'payment_status')
  String? paymentStatus;
  @JsonKey(name: 'shipping_status')
  int? shippingStatus;
  String? status;
  String? total;
  @JsonKey(name: 'first_name')
  String? firstName;
  @JsonKey(name: 'last_name')
  String? lastName;
  @JsonKey(name: 'payment_method')
  String? paymentMethod;
  @JsonKey(name: 'shipping_method')
  String? shippingMethod;
  DetailsCart? details;

  DataCart({
    this.id,
    this.paymentStatus,
    this.shippingStatus,
    this.status,
    this.total,
    this.firstName,
    this.lastName,
    this.paymentMethod,
    this.shippingMethod,
    this.details,
  });

  factory DataCart.fromJson(Map<String, dynamic> json) =>
      _$DataCartFromJson(json);

  Map<String, dynamic> toJson() => _$DataCartToJson(this);
}
