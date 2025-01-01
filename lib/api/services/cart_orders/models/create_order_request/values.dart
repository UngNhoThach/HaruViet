import 'package:json_annotation/json_annotation.dart';

part 'values.g.dart';

@JsonSerializable()
class Values {
  String? label;
  String? price;
  @JsonKey(name: 'price_type')
  String? priceType;

  Values({this.label, this.price, this.priceType});

  factory Values.fromJson(Map<String, dynamic> json) {
    return _$ValuesFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ValuesToJson(this);
}
