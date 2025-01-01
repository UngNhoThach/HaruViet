// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_review_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostReviewRequest _$PostReviewRequestFromJson(Map<String, dynamic> json) =>
    PostReviewRequest(
      productId: json['product_id'] as String,
      rating: (json['rating'] as num).toInt(),
      comment: json['comment'] as String?,
      customerId: json['customer_id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$PostReviewRequestToJson(PostReviewRequest instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'rating': instance.rating,
      'comment': instance.comment,
      'customer_id': instance.customerId,
      'name': instance.name,
    };
