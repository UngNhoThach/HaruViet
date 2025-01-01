// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataCategory _$DataCategoryFromJson(Map<String, dynamic> json) => DataCategory(
      id: json['id'] as String?,
      image: json['image'] as String?,
      alias: json['alias'] as String?,
      parent: json['parent'] as String?,
      descriptions: json['descriptions'] == null
          ? null
          : DescriptionsCategory.fromJson(
              json['descriptions'] as Map<String, dynamic>),
      subcategories: (json['subcategories'] as List<dynamic>?)
          ?.map((e) => Subcategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataCategoryToJson(DataCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'alias': instance.alias,
      'parent': instance.parent,
      'descriptions': instance.descriptions,
      'subcategories': instance.subcategories,
    };
