// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_description.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDescription _$ProductDescriptionFromJson(Map<String, dynamic> json) =>
    ProductDescription(
      productId: json['product_id'] as String?,
      lang: json['lang'] as String?,
      name: json['name'] as String?,
      keyword: json['keyword'],
      description: json['description'] as String?,
      content: json['content'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$ProductDescriptionToJson(ProductDescription instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'lang': instance.lang,
      'name': instance.name,
      'keyword': instance.keyword,
      'description': instance.description,
      'content': instance.content,
      'title': instance.title,
    };
