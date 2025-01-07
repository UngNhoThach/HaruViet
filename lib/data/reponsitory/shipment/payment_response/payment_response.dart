import 'package:json_annotation/json_annotation.dart';

import 'data_payment.dart';

part 'payment_response.g.dart';

@JsonSerializable()
class PaymentResponse {
  bool? success;
  String? message;
  List<DataPayment>? data;

  PaymentResponse({this.success, this.message, this.data});

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return _$PaymentResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PaymentResponseToJson(this);
}
