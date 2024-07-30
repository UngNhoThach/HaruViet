// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_product_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataProductDetail _$DataProductDetailFromJson(Map<String, dynamic> json) =>
    DataProductDetail(
      id: json['id'] as String?,
      promotionPrice: json['promotion_price'] == null
          ? null
          : ProductPromotionPrice.fromJson(
              json['promotion_price'] as Map<String, dynamic>),
      sku: json['sku'] as String?,
      upc: json['upc'],
      ean: json['ean'],
      jan: json['jan'],
      isbn: json['isbn'],
      mpn: json['mpn'],
      image: json['image'] as String?,
      brandId: json['brand_id'] as String?,
      supplierId: json['supplier_id'] as String?,
      price: json['price'] as String?,
      cost: json['cost'] as String?,
      stock: json['stock'] as int?,
      sold: json['sold'] as int?,
      minimum: json['minimum'] as int?,
      weightClass: json['weight_class'],
      weight: json['weight'] as String?,
      lengthClass: json['length_class'],
      length: json['length'] as String?,
      width: json['width'] as String?,
      height: json['height'] as String?,
      kind: json['kind'] as int?,
      property: json['property'] as String?,
      taxId: json['tax_id'] as String?,
      status: json['status'] as int?,
      approve: json['approve'] as int?,
      sort: json['sort'] as int?,
      view: json['view'] as int?,
      alias: json['alias'] as String?,
      dateLastview: json['date_lastview'],
      dateAvailable: json['date_available'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ImagesProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      descriptions: (json['descriptions'] as List<dynamic>?)
          ?.map((e) => ProductDescription.fromJson(e as Map<String, dynamic>))
          .toList(),
      attributes: json['attributes'] as List<dynamic>?,
    );

Map<String, dynamic> _$DataProductDetailToJson(DataProductDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'upc': instance.upc,
      'ean': instance.ean,
      'jan': instance.jan,
      'isbn': instance.isbn,
      'mpn': instance.mpn,
      'image': instance.image,
      'brand_id': instance.brandId,
      'supplier_id': instance.supplierId,
      'price': instance.price,
      'cost': instance.cost,
      'stock': instance.stock,
      'sold': instance.sold,
      'minimum': instance.minimum,
      'weight_class': instance.weightClass,
      'weight': instance.weight,
      'length_class': instance.lengthClass,
      'length': instance.length,
      'width': instance.width,
      'height': instance.height,
      'kind': instance.kind,
      'property': instance.property,
      'tax_id': instance.taxId,
      'status': instance.status,
      'approve': instance.approve,
      'sort': instance.sort,
      'view': instance.view,
      'alias': instance.alias,
      'date_lastview': instance.dateLastview,
      'date_available': instance.dateAvailable,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'images': instance.images,
      'descriptions': instance.descriptions,
      'attributes': instance.attributes,
      'promotion_price': instance.promotionPrice,
    };
