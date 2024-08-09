// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_reviews.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductReview _$ProductReviewFromJson(Map<String, dynamic> json) =>
    ProductReview(
      averageRating: json['average_rating'] as int?,
      totalReviews: json['total_reviews'] as int?,
    );

Map<String, dynamic> _$ProductReviewToJson(ProductReview instance) =>
    <String, dynamic>{
      'average_rating': instance.averageRating,
      'total_reviews': instance.totalReviews,
    };
