// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as String?,
      image: json['image'] as String?,
      alias: json['alias'] as String?,
      descriptions: json['descriptions'] == null
          ? null
          : ProductDescription.fromJson(
              json['descriptions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'alias': instance.alias,
      'descriptions': instance.descriptions,
    };
