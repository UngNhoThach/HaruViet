import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'payment_data.g.dart';

@JsonSerializable()
@CopyWith()
class PaymentData {
  @JsonKey(name: "payment_method")
  String? paymentMethod;
  @JsonKey(name: "index_shipping_method")
  int? indexShippingMethod;

  PaymentData({this.paymentMethod, this.indexShippingMethod});

  factory PaymentData.fromJson(Map<String, dynamic> json) =>
      _$PaymentDataFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentDataToJson(this);
}
