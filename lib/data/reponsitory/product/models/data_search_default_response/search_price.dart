import 'package:json_annotation/json_annotation.dart';

part 'search_price.g.dart';

@JsonSerializable()
class SearchPrice {
  @JsonKey(name: 'price_str')
  String? searchpriceStr;
  @JsonKey(name: 'final_price_str')
  String? finalSearchPriceStr;
  @JsonKey(name: 'promotion_percent')
  int? promotionPercent;
  String? price;

  SearchPrice({
    this.searchpriceStr,
    this.finalSearchPriceStr,
    this.promotionPercent,
    this.price,
  });

  factory SearchPrice.fromJson(Map<String, dynamic> json) =>
      _$SearchPriceFromJson(json);

  Map<String, dynamic> toJson() => _$SearchPriceToJson(this);
}
