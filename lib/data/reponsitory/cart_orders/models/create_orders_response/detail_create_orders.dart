import 'package:json_annotation/json_annotation.dart';

part 'detail_create_orders.g.dart';

@JsonSerializable()
class DetailCreateOrders {
  int? subtotal;
  int? shipping;
  int? discount;
  int? received;
  int? tax;
  @JsonKey(name: 'payment_status')
  int? paymentStatus;
  @JsonKey(name: 'shipping_status')
  int? shippingStatus;
  int? status;
  String? currency;
  @JsonKey(name: 'exchange_rate')
  int? exchangeRate;
  int? total;
  int? balance;
  @JsonKey(name: 'payment_method')
  String? paymentMethod;
  @JsonKey(name: 'shipping_method')
  String? shippingMethod;
  String? email;
  @JsonKey(name: 'first_name')
  String? firstName;
  @JsonKey(name: 'last_name')
  String? lastName;
  @JsonKey(name: 'first_name_kana')
  dynamic firstNameKana;
  @JsonKey(name: 'last_name_kana')
  dynamic lastNameKana;
  String? house;
  String? street;
  String? ward;
  String? district;
  String? province;
  dynamic postcode;
  @JsonKey(name: 'id_province')
  int? idProvince;
  @JsonKey(name: 'id_district')
  int? idDistrict;
  @JsonKey(name: 'id_ward')
  int? idWard;
  String? phone;
  String? country;
  dynamic company;
  dynamic comment;
  @JsonKey(name: 'customer_id')
  String? customerId;
  String? domain;
  String? id;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;

  DetailCreateOrders({
    this.subtotal,
    this.shipping,
    this.discount,
    this.received,
    this.tax,
    this.paymentStatus,
    this.shippingStatus,
    this.status,
    this.currency,
    this.exchangeRate,
    this.total,
    this.balance,
    this.paymentMethod,
    this.shippingMethod,
    this.email,
    this.firstName,
    this.lastName,
    this.firstNameKana,
    this.lastNameKana,
    this.house,
    this.street,
    this.ward,
    this.district,
    this.province,
    this.postcode,
    this.idProvince,
    this.idDistrict,
    this.idWard,
    this.phone,
    this.country,
    this.company,
    this.comment,
    this.customerId,
    this.domain,
    this.id,
    this.updatedAt,
    this.createdAt,
  });

  factory DetailCreateOrders.fromJson(Map<String, dynamic> json) {
    return _$DetailCreateOrdersFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DetailCreateOrdersToJson(this);
}
