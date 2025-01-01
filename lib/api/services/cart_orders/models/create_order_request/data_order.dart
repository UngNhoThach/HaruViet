import 'package:json_annotation/json_annotation.dart';

part 'data_order.g.dart';

@JsonSerializable()
class DataOrder {
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
  String? postcode;
  @JsonKey(name: 'id_province')
  int? idProvince;
  @JsonKey(name: 'id_district')
  int? idDistrict;
  @JsonKey(name: 'id_ward')
  int? idWard;
  String? phone;
  String? country;
  String? company;
  String? comment;

  DataOrder({
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
  });

  factory DataOrder.fromJson(Map<String, dynamic> json) {
    return _$DataOrderFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DataOrderToJson(this);
}
