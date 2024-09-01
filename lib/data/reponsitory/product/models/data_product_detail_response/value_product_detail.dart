import 'package:haruviet/data/reponsitory/product/models/price.dart';
import 'package:json_annotation/json_annotation.dart';

part 'value_product_detail.g.dart';

@JsonSerializable()
class ValueOptionProduct {
  String? id;
  Price? price;
  bool isSelected;
  @JsonKey(name: 'price_type')
  String? priceType;
  @JsonKey(name: 'title')
  String? title;
  String? descriptions;

  ValueOptionProduct({
    this.id,
    this.price,
    this.priceType,
    this.descriptions,
    this.title,
    this.isSelected = false,
  });

  factory ValueOptionProduct.fromJson(Map<String, dynamic> json) =>
      _$ValueOptionProductFromJson(json);

  Map<String, dynamic> toJson() => _$ValueOptionProductToJson(this);

  ValueOptionProduct copyWith({
    String? id,
    Price? price,
    bool? isSelected,
    String? priceType,
    String? title,
    String? descriptions,
  }) {
    return ValueOptionProduct(
      descriptions: descriptions ?? this.descriptions,
      id: id ?? this.id,
      isSelected: isSelected ?? this.isSelected,
      price: price ?? this.price,
      priceType: priceType ?? this.priceType,
      title: title ?? this.title,
    );
  }
}
