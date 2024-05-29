import 'package:json_annotation/json_annotation.dart';

part 'product_description.g.dart';

@JsonSerializable()
class ProductDescription {
  @JsonKey(name: 'product_id')
  String? productId;
  String? lang;
  String? name;
  dynamic keyword;
  String? description;
  String? content;

  ProductDescription({
    this.productId,
    this.lang,
    this.name,
    this.keyword,
    this.description,
    this.content,
  });

  factory ProductDescription.fromJson(Map<String, dynamic> json) {
    return _$ProductDescriptionFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductDescriptionToJson(this);
}
