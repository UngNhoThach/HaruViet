import 'package:json_annotation/json_annotation.dart';

part 'price.g.dart';

@JsonSerializable()
class Price {
  int? price;
  @JsonKey(name: 'price_str')
  String? priceStr;
  num? discountDetail;
  @JsonKey(name: 'exchange_rate')
  int? exchangeRate;
  int? totalPriceItem;
  String? currency;
  int? discountOrder;
  int? totalQuantity;

  Price(
      {this.price,
      this.priceStr,
      this.exchangeRate,
      this.totalPriceItem,
      this.totalQuantity,
      this.currency,
      this.discountOrder,
      this.discountDetail});

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);

  Map<String, dynamic> toJson() => _$PriceToJson(this);
}
