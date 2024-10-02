import 'package:json_annotation/json_annotation.dart';

import 'shipment_ext_fee.dart';
import 'shipment_options.dart';

part 'shipment_fee.g.dart';

@JsonSerializable()
class ShipmentFee {
  String? name;
  int? fee;
  @JsonKey(name: 'insurance_fee')
  int? insuranceFee;
  @JsonKey(name: 'include_vat')
  int? includeVat;
  @JsonKey(name: 'cost_id')
  int? costId;
  @JsonKey(name: 'delivery_type')
  String? deliveryType;
  int? a;
  String? dt;
  List<ShipmentExtFee>? extFees;
  @JsonKey(name: 'promotion_key')
  String? promotionKey;
  bool? delivery;
  @JsonKey(name: 'ship_fee_only')
  int? shipFeeOnly;
  double? distance;
  ShipmentOptions? options;

  ShipmentFee({
    this.name,
    this.fee,
    this.insuranceFee,
    this.includeVat,
    this.costId,
    this.deliveryType,
    this.a,
    this.dt,
    this.extFees,
    this.promotionKey,
    this.delivery,
    this.shipFeeOnly,
    this.distance,
    this.options,
  });

  factory ShipmentFee.fromJson(Map<String, dynamic> json) =>
      _$ShipmentFeeFromJson(json);

  Map<String, dynamic> toJson() => _$ShipmentFeeToJson(this);
}
