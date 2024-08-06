import 'package:json_annotation/json_annotation.dart';

part 'images_product.g.dart';

@JsonSerializable()
class ImagesProduct {
  String? id;
  String? image;
  @JsonKey(name: 'product_id')
  String? productId;

  ImagesProduct({this.id, this.image, this.productId});

  factory ImagesProduct.fromJson(Map<String, dynamic> json) {
    return _$ImagesProductFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ImagesProductToJson(this);
}
