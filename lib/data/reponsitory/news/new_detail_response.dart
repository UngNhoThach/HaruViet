import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'new_detail_response.g.dart';

@JsonSerializable()
@CopyWith()
class NewDetailResponse {
  @JsonKey(name: 'Id')
  int? id;
  @JsonKey(name: 'Code')
  String? code;
  @JsonKey(name: 'Name')
  String? name;
  @JsonKey(name: 'Image')
  String? image;
  //   final ValueNotifier<int>? amount;
  @JsonKey(name: 'Amount')
  String? amount;
  @JsonKey(name: 'Price')
  String? price;
  bool isCheck;

  NewDetailResponse({
    this.id,
    this.amount,
    this.code,
    this.image,
    this.name,
    this.price,
    this.isCheck = false,
  });

  factory NewDetailResponse.fromJson(Map<String, dynamic> json) {
    return _$NewDetailResponseFromJson(json);
  }

  static List<NewDetailResponse> fromJsonArray(
    List<dynamic> jsonArray,
  ) {
    return jsonArray
        .map(
          (dynamic e) => NewDetailResponse.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  Map<String, dynamic> toJson() => _$NewDetailResponseToJson(this);
}
