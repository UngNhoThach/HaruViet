import 'package:haruviet/data/reponsitory/product/models/brand.dart';
import 'package:haruviet/data/reponsitory/product/models/category.dart';
import 'package:haruviet/data/reponsitory/product/models/data_list_product/product_promotion_price_list.dart';
import 'package:haruviet/data/reponsitory/product/models/supplier.dart';
import 'package:haruviet/data/reponsitory/product/models/images_product.dart';
import 'package:haruviet/data/reponsitory/product/models/price.dart';
import 'package:haruviet/data/reponsitory/product/models/product_description.dart';
import 'package:json_annotation/json_annotation.dart';
import 'attributes_product_detail/attributes_product_detail.dart';
import 'option_product_detail.dart';
import 'promotiondetail_product_detail.dart';

part 'data_product_detail_response.g.dart';

@JsonSerializable()
class DataProductDetailResponse {
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
  String? weightClass;
  String? weight;
  int? kind;
  String? property;
  @JsonKey(name: 'tax_id')
  String? taxId;
  int? approve;
  int? sort;
  int? view;
  String? alias;
  String? url;
  @JsonKey(name: 'date_lastview')
  String? dateLastview;
  @JsonKey(name: 'date_available')
  dynamic dateAvailable;
  ProductDescription? descriptions;
  List<Category>? categories;
  List<ImagesProduct>? images;
  @JsonKey(name: 'promotion_price')
  ProductPromotionPriceList? promotionPrice;
  List<Promotiondetail>? promotiondetails;
  dynamic reviews;
  List<Option>? options;
  List<AttributesProductDetail>? attributes;

  DataProductDetailResponse({
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
    this.property,
    this.taxId,
    this.approve,
    this.sort,
    this.view,
    this.alias,
    this.url,
    this.dateLastview,
    this.dateAvailable,
    this.descriptions,
    this.categories,
    this.images,
    this.promotionPrice,
    this.promotiondetails,
    this.reviews,
    this.options,
    this.attributes,
  });

  factory DataProductDetailResponse.fromJson(Map<String, dynamic> json) {
    return _$DataProductDetailResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DataProductDetailResponseToJson(this);
}
