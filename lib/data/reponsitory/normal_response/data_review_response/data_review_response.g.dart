// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_review_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataReviewResponse _$DataReviewResponseFromJson(Map<String, dynamic> json) =>
    DataReviewResponse(
      id: json['id'] as String?,
      comment: json['comment'] as String?,
      rating: (json['rating'] as num?)?.toInt(),
      name: json['name'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DataReviewResponseToJson(DataReviewResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'comment': instance.comment,
      'rating': instance.rating,
      'name': instance.name,
      'images': instance.images,
    };
