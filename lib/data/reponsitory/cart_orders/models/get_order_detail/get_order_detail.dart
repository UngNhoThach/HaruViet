import 'package:haruviet/data/reponsitory/cart_orders/models/cart_order_response/details_cart.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_order_detail.g.dart';

@JsonSerializable()
class GetOrderDetail {
  String? id;
  @JsonKey(name: 'customer_id')
  String? customerId;
  String? subtotal;
  String? shipping;
  String? discount;
  @JsonKey(name: 'payment_status')
  int? paymentStatus;
  @JsonKey(name: 'shipping_status')
  int? shippingStatus;
  int? status;
  String? tax;
  @JsonKey(name: 'other_fee')
  String? otherFee;
  String? total;
  String? currency;
  @JsonKey(name: 'exchange_rate')
  String? exchangeRate;
  String? received;
  String? balance;
  @JsonKey(name: 'first_name')
  String? firstName;
  @JsonKey(name: 'last_name')
  String? lastName;
  String? address1;
  String? address2;
  dynamic address3;
  String? country;
  String? phone;
  dynamic comment;
  @JsonKey(name: 'payment_method')
  String? paymentMethod;
  @JsonKey(name: 'shipping_method')
  String? shippingMethod;
  List<DetailsCart>? details;

  GetOrderDetail({
    this.id,
    this.customerId,
    this.subtotal,
    this.shipping,
    this.discount,
    this.paymentStatus,
    this.shippingStatus,
    this.status,
    this.tax,
    this.otherFee,
    this.total,
    this.currency,
    this.exchangeRate,
    this.received,
    this.balance,
    this.firstName,
    this.lastName,
    this.address1,
    this.address2,
    this.address3,
    this.country,
    this.phone,
    this.comment,
    this.paymentMethod,
    this.shippingMethod,
    this.details,
  });

  factory GetOrderDetail.fromJson(Map<String, dynamic> json) {
    return _$GetOrderDetailFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetOrderDetailToJson(this);
}
