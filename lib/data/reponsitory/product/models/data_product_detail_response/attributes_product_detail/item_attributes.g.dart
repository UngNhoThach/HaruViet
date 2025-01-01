// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemAttributes _$ItemAttributesFromJson(Map<String, dynamic> json) =>
    ItemAttributes(
      attributeId: json['attribute_id'] as String?,
      title: json['title'] as String?,
      values: (json['values'] as List<dynamic>?)
          ?.map((e) => ValueAttributes.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemAttributesToJson(ItemAttributes instance) =>
    <String, dynamic>{
      'attribute_id': instance.attributeId,
      'title': instance.title,
      'values': instance.values,
    };
