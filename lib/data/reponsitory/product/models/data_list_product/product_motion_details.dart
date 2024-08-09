import 'package:json_annotation/json_annotation.dart';

part 'product_motion_details.g.dart';

@JsonSerializable()
class ProductMotionDetails {
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'promotion_type')
  String? promotionType;

  ProductMotionDetails({
    this.description,
    this.promotionType,
  });

  factory ProductMotionDetails.fromJson(Map<String, dynamic> json) {
    return _$ProductMotionDetailsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductMotionDetailsToJson(this);
}
