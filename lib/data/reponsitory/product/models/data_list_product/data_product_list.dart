import 'package:haruviet/data/reponsitory/product/models/brand.dart';
import 'package:haruviet/data/reponsitory/product/models/category.dart';
import 'package:haruviet/data/reponsitory/product/models/images_product.dart';
import 'package:haruviet/data/reponsitory/product/models/product_description.dart';
import 'package:haruviet/data/reponsitory/product/models/product_promotion_price.dart';
import 'package:json_annotation/json_annotation.dart';

import '../price.dart';
import '../supplier.dart';
import 'product_promotion_price_list.dart';

part 'data_product_list.g.dart';

@JsonSerializable()
class DataProduct {
  String? id;
  String? sku;
  String? image;
  Brand? brand;
  Supplier? supplier;
  Price? price;
  String? cost;
  int? stock;
  int? sold;
  int? minimum;
  @JsonKey(name: 'weight_class')
  dynamic weightClass;
  String? weight;
  int? kind;
  @JsonKey(name: 'tax_id')
  String? taxId;
  int? approve;
  int? sort;
  int? view;
  @JsonKey(name: 'date_lastview')
  dynamic dateLastview;
  @JsonKey(name: 'date_available')
  dynamic dateAvailable;
  List<ProductDescription>? descriptions;
  List<Category>? categories;
  List<ImagesProduct>? images;
  @JsonKey(name: 'promotion_price')
  ProductPromotionPriceList? promotionPrice;

  DataProduct({
    this.id,
    this.sku,
    this.image,
    this.brand,
    this.supplier,
    this.price,
    this.cost,
    this.stock,
    this.sold,
    this.minimum,
    this.weightClass,
    this.weight,
    this.kind,
    this.taxId,
    this.approve,
    this.sort,
    this.view,
    this.dateLastview,
    this.dateAvailable,
    this.descriptions,
    this.categories,
    this.images,
    this.promotionPrice,
  });

  factory DataProduct.fromJson(Map<String, dynamic> json) {
    return _$DataProductFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DataProductToJson(this);
}
