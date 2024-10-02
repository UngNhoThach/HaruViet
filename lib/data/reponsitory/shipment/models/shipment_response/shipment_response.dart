import 'package:json_annotation/json_annotation.dart';

import 'shipment_fee.dart';

part 'shipment_response.g.dart';

@JsonSerializable()
class ShipmentResponse {
  bool? success;
  ShipmentFee? fee;
  String? message;

  ShipmentResponse({this.success, this.fee, this.message});

  factory ShipmentResponse.fromJson(Map<String, dynamic> json) {
    return _$ShipmentResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ShipmentResponseToJson(this);
}
