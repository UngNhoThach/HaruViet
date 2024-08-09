// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_product_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataProduct _$DataProductFromJson(Map<String, dynamic> json) => DataProduct(
      id: json['id'] as String?,
      sku: json['sku'] as String?,
      image: json['image'] as String?,
      brand: json['brand'] == null
          ? null
          : Brand.fromJson(json['brand'] as Map<String, dynamic>),
      supplier: json['supplier'] == null
          ? null
          : Supplier.fromJson(json['supplier'] as Map<String, dynamic>),
      price: json['price'] == null
          ? null
          : Price.fromJson(json['price'] as Map<String, dynamic>),
      cost: json['cost'] as String?,
      stock: json['stock'] as int?,
      sold: json['sold'] as int?,
      minimum: json['minimum'] as int?,
      weightClass: json['weight_class'],
      weight: json['weight'] as String?,
      kind: json['kind'] as int?,
      taxId: json['tax_id'] as String?,
      approve: json['approve'] as int?,
      sort: json['sort'] as int?,
      view: json['view'] as int?,
      dateLastview: json['date_lastview'] as String?,
      dateAvailable: json['date_available'],
      descriptions: json['descriptions'] == null
          ? null
          : ProductDescription.fromJson(
              json['descriptions'] as Map<String, dynamic>),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ImagesProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      promotionPrice: json['promotion_price'] == null
          ? null
          : ProductPromotionPriceList.fromJson(
              json['promotion_price'] as Map<String, dynamic>),
      reviews: json['reviews'] == null
          ? null
          : ProductReview.fromJson(json['reviews'] as Map<String, dynamic>),
      promotionDetails: (json['promotiondetails'] as List<dynamic>?)
          ?.map((e) => ProductMotionDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataProductToJson(DataProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'image': instance.image,
      'brand': instance.brand,
      'supplier': instance.supplier,
      'price': instance.price,
      'cost': instance.cost,
      'stock': instance.stock,
      'sold': instance.sold,
      'minimum': instance.minimum,
      'weight_class': instance.weightClass,
      'weight': instance.weight,
      'kind': instance.kind,
      'tax_id': instance.taxId,
      'approve': instance.approve,
      'sort': instance.sort,
      'view': instance.view,
      'date_lastview': instance.dateLastview,
      'date_available': instance.dateAvailable,
      'descriptions': instance.descriptions,
      'categories': instance.categories,
      'images': instance.images,
      'promotion_price': instance.promotionPrice,
      'promotiondetails': instance.promotionDetails,
      'reviews': instance.reviews,
    };
