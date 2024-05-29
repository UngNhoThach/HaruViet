import 'package:json_annotation/json_annotation.dart';

import 'product_description.dart';

part 'data_product.g.dart';

@JsonSerializable()
class DataProduct {
  String? id;
  String? sku;
  dynamic upc;
  dynamic ean;
  dynamic jan;
  dynamic isbn;
  dynamic mpn;
  String? image;
  @JsonKey(name: 'brand_id')
  String? brandId;
  @JsonKey(name: 'supplier_id')
  String? supplierId;
  String? price;
  String? cost;
  int? stock;
  int? sold;
  int? minimum;
  @JsonKey(name: 'weight_class')
  dynamic weightClass;
  String? weight;
  @JsonKey(name: 'length_class')
  dynamic lengthClass;
  String? length;
  String? width;
  String? height;
  int? kind;
  String? property;
  @JsonKey(name: 'tax_id')
  String? taxId;
  int? status;
  int? approve;
  int? sort;
  int? view;
  String? alias;
  @JsonKey(name: 'date_lastview')
  dynamic dateLastview;
  @JsonKey(name: 'date_available')
  dynamic dateAvailable;
  @JsonKey(name: 'created_at')
  dynamic createdAt;
  @JsonKey(name: 'updated_at')
  dynamic updatedAt;
  List<dynamic>? images;
  List<ProductDescription>? descriptions;
  @JsonKey(name: 'promotion_price')
  dynamic promotionPrice;
  List<dynamic>? attributes;

  DataProduct({
    this.id,
    this.sku,
    this.upc,
    this.ean,
    this.jan,
    this.isbn,
    this.mpn,
    this.image,
    this.brandId,
    this.supplierId,
    this.price,
    this.cost,
    this.stock,
    this.sold,
    this.minimum,
    this.weightClass,
    this.weight,
    this.lengthClass,
    this.length,
    this.width,
    this.height,
    this.kind,
    this.property,
    this.taxId,
    this.status,
    this.approve,
    this.sort,
    this.view,
    this.alias,
    this.dateLastview,
    this.dateAvailable,
    this.createdAt,
    this.updatedAt,
    this.images,
    this.descriptions,
    this.promotionPrice,
    this.attributes,
  });

  factory DataProduct.fromJson(Map<String, dynamic> json) =>
      _$DataProductFromJson(json);

  Map<String, dynamic> toJson() => _$DataProductToJson(this);
}
