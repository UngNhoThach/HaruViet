// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subcategory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subcategory _$SubcategoryFromJson(Map<String, dynamic> json) => Subcategory(
      id: json['id'] as String?,
      image: json['image'] as String?,
      alias: json['alias'] as String?,
      parent: json['parent'] as String?,
      descriptions: json['descriptions'] == null
          ? null
          : DescriptionsCategory.fromJson(
              json['descriptions'] as Map<String, dynamic>),
      subcategories: json['subcategories'] as List<dynamic>?,
    );

Map<String, dynamic> _$SubcategoryToJson(Subcategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'alias': instance.alias,
      'parent': instance.parent,
      'descriptions': instance.descriptions,
      'subcategories': instance.subcategories,
    };
