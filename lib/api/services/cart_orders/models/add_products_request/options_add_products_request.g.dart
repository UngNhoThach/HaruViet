// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'options_add_products_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionsAddProductsRequest _$OptionsAddProductsRequestFromJson(
        Map<String, dynamic> json) =>
    OptionsAddProductsRequest(
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$OptionsAddProductsRequestToJson(
        OptionsAddProductsRequest instance) =>
    <String, dynamic>{
      'options': instance.options,
    };
