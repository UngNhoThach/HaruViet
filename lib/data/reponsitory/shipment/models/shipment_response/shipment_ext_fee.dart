import 'package:json_annotation/json_annotation.dart';

part 'shipment_ext_fee.g.dart';

@JsonSerializable()
class ShipmentExtFee {
  String? display;
  String? title;
  int? amount;
  String? type;
  @JsonKey(name: 'tag_id')
  int? tagId;

  ShipmentExtFee(
      {this.display, this.title, this.amount, this.type, this.tagId});

  factory ShipmentExtFee.fromJson(Map<String, dynamic> json) {
    return _$ShipmentExtFeeFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ShipmentExtFeeToJson(this);
}
