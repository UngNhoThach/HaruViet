import 'package:json_annotation/json_annotation.dart';

import 'shipping_standard.dart';

part 'shipping_response.g.dart';

@JsonSerializable()
class ShippingResponse {
  @JsonKey(name: 'ShippingStandard')
  ShippingStandard? shippingStandard;

  ShippingResponse({this.shippingStandard});

  factory ShippingResponse.fromJson(Map<String, dynamic> json) {
    return _$ShippingResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ShippingResponseToJson(this);
}
