// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_product_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataProduct _$DataProductFromJson(Map<String, dynamic> json) => DataProduct(
      id: json['id'] as String?,
      promotiondetails: (json['promotiondetails'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : Promotiondetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      attributes: (json['attributes'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : AttributesProductDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      promotionPrice: json['promotion_price'] == null
          ? null
          : ProductPromotionPriceList.fromJson(
              json['promotion_price'] as Map<String, dynamic>),
      discountDetail: (json['discountDetail'] as num?)?.toInt() ?? 0,
      totalPriceItem: (json['totalPriceItem'] as num?)?.toDouble(),
      totalQuantity: (json['totalQuantity'] as num?)?.toInt(),
      sku: json['sku'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : Option.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      stock: (json['stock'] as num?)?.toInt(),
      sold: (json['sold'] as num?)?.toInt(),
      minimum: (json['minimum'] as num?)?.toInt(),
      weightClass: json['weight_class'],
      weight: json['weight'] as String?,
      kind: (json['kind'] as num?)?.toInt(),
      taxId: json['tax_id'] as String?,
      approve: (json['approve'] as num?)?.toInt(),
      sort: (json['sort'] as num?)?.toInt(),
      view: (json['view'] as num?)?.toInt(),
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
      discount: json['discount'] == null
          ? null
          : ProductPromotionPriceList.fromJson(
              json['discount'] as Map<String, dynamic>),
      reviews: json['reviews'] == null
          ? null
          : ReviewsResponse.fromJson(json['reviews'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataProductToJson(DataProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'image': instance.image,
      'brand': instance.brand,
      'supplier': instance.supplier,
      'totalQuantity': instance.totalQuantity,
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
      'totalPriceItem': instance.totalPriceItem,
      'date_lastview': instance.dateLastview,
      'date_available': instance.dateAvailable,
      'descriptions': instance.descriptions,
      'categories': instance.categories,
      'images': instance.images,
      'discount': instance.discount,
      'reviews': instance.reviews,
      'options': instance.options,
      'discountDetail': instance.discountDetail,
      'promotion_price': instance.promotionPrice,
      'attributes': instance.attributes,
      'promotiondetails': instance.promotiondetails,
    };
