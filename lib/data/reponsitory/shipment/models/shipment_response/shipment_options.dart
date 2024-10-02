import 'package:json_annotation/json_annotation.dart';

part 'shipment_options.g.dart';

@JsonSerializable()
class ShipmentOptions {
  String? name;
  String? title;
  int? shipMoney;
  String? shipMoneyText;
  String? vatText;
  String? desc;
  String? coupon;
  int? maxUses;
  int? maxDates;
  String? maxDateString;
  String? content;
  String? activatedDate;
  String? couponTitle;
  String? discount;

  ShipmentOptions({
    this.name,
    this.title,
    this.shipMoney,
    this.shipMoneyText,
    this.vatText,
    this.desc,
    this.coupon,
    this.maxUses,
    this.maxDates,
    this.maxDateString,
    this.content,
    this.activatedDate,
    this.couponTitle,
    this.discount,
  });

  factory ShipmentOptions.fromJson(Map<String, dynamic> json) {
    return _$ShipmentOptionsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ShipmentOptionsToJson(this);
}
