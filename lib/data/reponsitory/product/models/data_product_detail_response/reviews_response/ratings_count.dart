import 'package:json_annotation/json_annotation.dart';

part 'ratings_count.g.dart';

@JsonSerializable()
class RatingsCount {
  @JsonKey(name: '5_star')
  int? star5;
  @JsonKey(name: '4_star')
  int? star4;
  @JsonKey(name: '3_star')
  int? star3;
  @JsonKey(name: '2_star')
  int? star2;
  @JsonKey(name: '1_star')
  int? star1;

  RatingsCount({
    this.star5,
    this.star4,
    this.star3,
    this.star2,
    this.star1,
  });

  factory RatingsCount.fromJson(Map<String, dynamic> json) {
    return _$RatingsCountFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RatingsCountToJson(this);
}
