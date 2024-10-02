import 'package:json_annotation/json_annotation.dart';

part 'gift_check_order_price_response.g.dart';

@JsonSerializable()
class GiftCheckOrderPriceResponse {
  @JsonKey(name: 'gift_id')
  String? giftId;
  @JsonKey(name: 'gift_type')
  String? giftType;
  @JsonKey(name: 'quantity')
  int? quantity;

  GiftCheckOrderPriceResponse({
    this.giftId,
    this.giftType,
    this.quantity,
  });

  factory GiftCheckOrderPriceResponse.fromJson(Map<String, dynamic> json) {
    return _$GiftCheckOrderPriceResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GiftCheckOrderPriceResponseToJson(this);
}
