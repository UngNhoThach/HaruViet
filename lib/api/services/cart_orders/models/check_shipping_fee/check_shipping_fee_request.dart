import 'package:json_annotation/json_annotation.dart';

part 'check_shipping_fee_request.g.dart';

@JsonSerializable()
class CheckShippingFeeRequest {
  String? iud;
  @JsonKey(name: 'address_id')
  String? addressId;
  @JsonKey(name: 'payment_method')
  String? paymentMethod;

  CheckShippingFeeRequest({this.iud, this.addressId, this.paymentMethod});

  factory CheckShippingFeeRequest.fromJson(Map<String, dynamic> json) {
    return _$CheckShippingFeeRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CheckShippingFeeRequestToJson(this);
}
