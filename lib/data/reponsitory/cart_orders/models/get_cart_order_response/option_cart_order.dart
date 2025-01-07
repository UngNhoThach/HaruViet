import 'package:json_annotation/json_annotation.dart';

part 'option_cart_order.g.dart';

@JsonSerializable()
class OptionCartOrder {
  String? id;
  @JsonKey(name: 'option_id')
  String? optionId;
  String? price;
  @JsonKey(name: 'price_type')
  String? priceType;
  int? position;
  String? lang;
  String? title;
  String? type;
  @JsonKey(name: 'option_title')
  String? optionTitle;

  OptionCartOrder({
    this.id,
    this.optionId,
    this.price,
    this.priceType,
    this.position,
    this.lang,
    this.title,
    this.type,
    this.optionTitle,
  });

  factory OptionCartOrder.fromJson(Map<String, dynamic> json) {
    return _$OptionCartOrderFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OptionCartOrderToJson(this);
}
