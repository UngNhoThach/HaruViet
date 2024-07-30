import 'package:json_annotation/json_annotation.dart';

part 'price.g.dart';

@JsonSerializable()
class Price {
  int? price;
  @JsonKey(name: 'price_str')
  String? priceStr;
  @JsonKey(name: 'exchange_rate')
  int? exchangeRate;
  String? currency;

  Price({this.price, this.priceStr, this.exchangeRate, this.currency});

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);

  Map<String, dynamic> toJson() => _$PriceToJson(this);
}
