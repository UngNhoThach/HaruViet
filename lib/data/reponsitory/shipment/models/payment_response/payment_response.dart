import 'package:json_annotation/json_annotation.dart';

import 'cash.dart';

part 'payment_response.g.dart';

@JsonSerializable()
class PaymentResponse {
  @JsonKey(name: 'Cash')
  Cash? cash;

  PaymentResponse({this.cash});

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return _$PaymentResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PaymentResponseToJson(this);
}
