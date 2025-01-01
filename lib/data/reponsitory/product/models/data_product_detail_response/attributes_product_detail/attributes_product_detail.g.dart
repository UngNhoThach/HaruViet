// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attributes_product_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttributesProductDetail _$AttributesProductDetailFromJson(
        Map<String, dynamic> json) =>
    AttributesProductDetail(
      attributesetsId: json['attributesets_id'] as String?,
      title: json['title'] as String?,
      item: (json['item'] as List<dynamic>?)
          ?.map((e) => ItemAttributes.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AttributesProductDetailToJson(
        AttributesProductDetail instance) =>
    <String, dynamic>{
      'attributesets_id': instance.attributesetsId,
      'title': instance.title,
      'item': instance.item,
    };
