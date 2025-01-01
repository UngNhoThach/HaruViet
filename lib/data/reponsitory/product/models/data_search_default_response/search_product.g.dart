// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchProduct _$SearchProductFromJson(Map<String, dynamic> json) =>
    SearchProduct(
      id: json['id'] as String?,
      nameFound: json['name_found'] as String?,
      name: json['name'] as String?,
      price: json['price'] == null
          ? null
          : SearchPrice.fromJson(json['price'] as Map<String, dynamic>),
      image: json['image'] as String?,
      isOutOfStock: (json['is_out_of_stock'] as num?)?.toInt(),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$SearchProductToJson(SearchProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_found': instance.nameFound,
      'name': instance.name,
      'price': instance.price,
      'image': instance.image,
      'is_out_of_stock': instance.isOutOfStock,
      'url': instance.url,
    };
