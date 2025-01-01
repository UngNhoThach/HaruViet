// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_reviews.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataReviews _$DataReviewsFromJson(Map<String, dynamic> json) => DataReviews(
      id: json['id'] as String?,
      comment: json['comment'] as String?,
      rating: (json['rating'] as num?)?.toInt(),
      name: json['name'] as String?,
      images: json['images'] as List<dynamic>?,
    );

Map<String, dynamic> _$DataReviewsToJson(DataReviews instance) =>
    <String, dynamic>{
      'id': instance.id,
      'comment': instance.comment,
      'rating': instance.rating,
      'name': instance.name,
      'images': instance.images,
    };
