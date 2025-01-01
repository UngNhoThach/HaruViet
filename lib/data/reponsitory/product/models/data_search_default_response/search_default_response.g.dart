// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_default_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchDefaultResponse _$SearchDefaultResponseFromJson(
        Map<String, dynamic> json) =>
    SearchDefaultResponse(
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => SearchCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => SearchProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      remaining: (json['remaining'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SearchDefaultResponseToJson(
        SearchDefaultResponse instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      'products': instance.products,
      'remaining': instance.remaining,
    };
