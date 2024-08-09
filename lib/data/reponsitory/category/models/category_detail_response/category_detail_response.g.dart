// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryDetailResponse _$CategoryDetailResponseFromJson(
        Map<String, dynamic> json) =>
    CategoryDetailResponse(
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      filterableAttributes: json['filterableAttributes'] as List<dynamic>?,
      products: json['products'] == null
          ? null
          : ListProduct.fromJson(json['products'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoryDetailResponseToJson(
        CategoryDetailResponse instance) =>
    <String, dynamic>{
      'category': instance.category,
      'filterableAttributes': instance.filterableAttributes,
      'products': instance.products,
    };
