// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subcategory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subcategory _$SubcategoryFromJson(Map<String, dynamic> json) => Subcategory(
      id: json['id'] as String?,
      name: json['name'],
      image: json['image'] as String?,
      alias: json['alias'] as String?,
      descriptions: (json['descriptions'] as List<dynamic>?)
          ?.map((e) => ProductDescription.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubcategoryToJson(Subcategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'alias': instance.alias,
      'descriptions': instance.descriptions,
    };
