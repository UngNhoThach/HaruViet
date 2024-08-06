// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_product_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataProductDetailResponse _$DataProductDetailResponseFromJson(
        Map<String, dynamic> json) =>
    DataProductDetailResponse(
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
      weightClass: json['weight_class'] as String?,
      weight: json['weight'] as String?,
      kind: json['kind'] as int?,
      property: json['property'] as String?,
      taxId: json['tax_id'] as String?,
      approve: json['approve'] as int?,
      sort: json['sort'] as int?,
      view: json['view'] as int?,
      alias: json['alias'] as String?,
      url: json['url'] as String?,
      dateLastview: json['date_lastview'] as String?,
      dateAvailable: json['date_available'],
      descriptions: json['descriptions'] == null
          ? null
          : ProductDescription.fromJson(
              json['descriptions'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ImagesProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      promotionPrice: json['promotion_price'] == null
          ? null
          : ProductPromotionPriceList.fromJson(
              json['promotion_price'] as Map<String, dynamic>),
      promotiondetails: (json['promotiondetails'] as List<dynamic>?)
          ?.map((e) => Promotiondetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviews: json['reviews'],
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataProductDetailResponseToJson(
        DataProductDetailResponse instance) =>
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
      'property': instance.property,
      'tax_id': instance.taxId,
      'approve': instance.approve,
      'sort': instance.sort,
      'view': instance.view,
      'alias': instance.alias,
      'url': instance.url,
      'date_lastview': instance.dateLastview,
      'date_available': instance.dateAvailable,
      'descriptions': instance.descriptions,
      'images': instance.images,
      'promotion_price': instance.promotionPrice,
      'promotiondetails': instance.promotiondetails,
      'reviews': instance.reviews,
      'options': instance.options,
    };
