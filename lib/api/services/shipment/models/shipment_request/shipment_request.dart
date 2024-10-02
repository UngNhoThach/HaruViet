import 'package:json_annotation/json_annotation.dart';

part 'shipment_request.g.dart';

@JsonSerializable()
class ShipmentRequest {
  @JsonKey(name: 'pick_address_id')
  String? pickAddressId;
  @JsonKey(name: 'pick_address')
  String? pickAddress;
  @JsonKey(name: 'pick_ward')
  String? pickWard;
  @JsonKey(name: 'pick_street')
  String? pickStreet;
  String? ward;
  String? street;

  @JsonKey(name: 'pick_province')
  String? pickProvince;
  @JsonKey(name: 'pick_district')
  String? pickDistrict;
  String? province;
  String? district;
  String? address;
  int? weight;
  int? value;
  String? transport;
  @JsonKey(name: 'deliver_option')
  String? deliverOption;
  List<int>? tags;

  ShipmentRequest({
    this.pickAddressId,
    this.pickAddress,
    this.pickWard,
    this.pickStreet,
    this.ward,
    this.street,
    this.pickProvince,
    this.pickDistrict,
    this.province,
    this.district,
    this.address,
    this.weight,
    this.value,
    this.transport,
    this.deliverOption,
    this.tags,
  });

  factory ShipmentRequest.fromJson(Map<String, dynamic> json) {
    return _$ShipmentRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ShipmentRequestToJson(this);
}
