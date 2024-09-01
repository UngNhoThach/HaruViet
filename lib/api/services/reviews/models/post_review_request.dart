import 'package:json_annotation/json_annotation.dart';

part 'post_review_request.g.dart';

@JsonSerializable()
class PostReviewRequest {
  @JsonKey(name: 'product_id')
  String productId;
  @JsonKey(name: 'rating')
  int rating;
  @JsonKey(name: 'comment')
  String? comment;
  @JsonKey(name: 'customer_id')
  String? customerId;
  @JsonKey(name: 'name')
  String? name;

  PostReviewRequest({
    required this.productId,
    required this.rating,
    this.comment,
    this.customerId,
    this.name,
  });

  Map<String, dynamic> toJson() => _$PostReviewRequestToJson(this);
}
