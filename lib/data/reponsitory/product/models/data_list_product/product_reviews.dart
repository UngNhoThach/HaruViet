import 'package:json_annotation/json_annotation.dart';

part 'product_reviews.g.dart';

@JsonSerializable()
class ProductReview {
  @JsonKey(name: 'average_rating')
  double? averageRating;
  @JsonKey(name: 'total_reviews')
  double? totalReviews;

  ProductReview({
    this.averageRating,
    this.totalReviews,
  });

  factory ProductReview.fromJson(Map<String, dynamic> json) {
    return _$ProductReviewFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductReviewToJson(this);
}
