import 'package:haruviet/data/reponsitory/product/models/brand.dart';
import 'package:haruviet/data/reponsitory/product/models/category.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/attributes_product_detail/attributes_product_detail.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/option_product_detail.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/promotiondetail_product_detail.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/reviews_response/reviews_response.dart';
import 'package:haruviet/data/reponsitory/product/models/images_product.dart';
import 'package:haruviet/data/reponsitory/product/models/product_description.dart';
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
  int? totalQuantity;
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
  double? totalPriceItem;
  @JsonKey(name: 'date_lastview')
  String? dateLastview;
  @JsonKey(name: 'date_available')
  dynamic dateAvailable;
  ProductDescription? descriptions;
  List<Category>? categories;
  List<ImagesProduct>? images;
  @JsonKey(name: 'discount')
  ProductPromotionPriceList? discount;
  @JsonKey(name: 'reviews')
  ReviewsResponse? reviews;
  List<Option?>? options;
  int discountDetail;
  @JsonKey(name: 'promotion_price')
  ProductPromotionPriceList? promotionPrice;
  List<AttributesProductDetail?>? attributes;
  @JsonKey(name: 'promotiondetails')
  List<Promotiondetail?>? promotiondetails;

  DataProduct({
    this.id,
    this.promotiondetails,
    this.attributes,
    this.promotionPrice,
    this.discountDetail = 0,
    this.totalPriceItem,
    this.totalQuantity,
    this.sku,
    this.options,
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
    this.discount,
    this.reviews,
  });

  factory DataProduct.fromJson(Map<String, dynamic> json) {
    return _$DataProductFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DataProductToJson(this);
}
