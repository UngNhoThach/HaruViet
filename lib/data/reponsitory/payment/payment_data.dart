import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'payment_data.g.dart';

@JsonSerializable()
@CopyWith()
class PaymentData {
  @JsonKey(name: "payment_method")
  String? paymentMethod;
  @JsonKey(name: "key")
  String? keyPaymentMethod;

  PaymentData({this.paymentMethod, this.keyPaymentMethod});

  factory PaymentData.fromJson(Map<String, dynamic> json) =>
      _$PaymentDataFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentDataToJson(this);
}
