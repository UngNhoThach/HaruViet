import 'package:json_annotation/json_annotation.dart';

part 'product_reviews.g.dart';

@JsonSerializable()
class ProductReview {
  @JsonKey(name: 'average_rating')
  int? averageRating;
  @JsonKey(name: 'total_reviews')
  int? totalReviews;

  ProductReview({
    this.averageRating,
    this.totalReviews,
  });

  factory ProductReview.fromJson(Map<String, dynamic> json) {
    return _$ProductReviewFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductReviewToJson(this);
}
