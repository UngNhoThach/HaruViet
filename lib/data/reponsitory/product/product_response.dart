import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_response.g.dart';

@JsonSerializable()
@CopyWith()
class ProductResponse {
  @JsonKey(name: 'Id')
  int? id;
  @JsonKey(name: 'Code')
  String? code;
  @JsonKey(name: 'Name')
  String? name;
  @JsonKey(name: 'Image')
  String? image;
  //   final ValueNotifier<int>? amount;
  @JsonKey(name: 'Amount')
  String? amount;
  @JsonKey(name: 'Price')
  String? price;
  bool isCheck;

  ProductResponse({
    this.id,
    this.amount,
    this.code,
    this.image,
    this.name,
    this.price,
    this.isCheck = false,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return _$ProductResponseFromJson(json);
  }

  static List<ProductResponse> fromJsonArray(
    List<dynamic> jsonArray,
  ) {
    return jsonArray
        .map(
          (dynamic e) => ProductResponse.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}
