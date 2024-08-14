// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      alias: json['alias'] as String?,
      descriptions: json['descriptions'] == null
          ? null
          : ProductDescription.fromJson(
              json['descriptions'] as Map<String, dynamic>),
      subcategories: (json['subcategories'] as List<dynamic>?)
          ?.map((e) => Subcategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'alias': instance.alias,
      'descriptions': instance.descriptions,
      'subcategories': instance.subcategories,
    };
