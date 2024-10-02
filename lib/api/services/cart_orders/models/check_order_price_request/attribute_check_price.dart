import 'package:json_annotation/json_annotation.dart';

part 'attribute_check_price.g.dart';

@JsonSerializable()
class AttributeCheckPrice {
  List<String?>? options;

  AttributeCheckPrice({this.options});

  factory AttributeCheckPrice.fromJson(Map<String, dynamic> json) {
    return _$AttributeCheckPriceFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AttributeCheckPriceToJson(this);
}
