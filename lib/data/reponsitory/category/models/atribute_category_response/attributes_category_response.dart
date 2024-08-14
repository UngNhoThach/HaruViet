import 'package:json_annotation/json_annotation.dart';

import 'descriptions_attributes.dart';
import 'value_attributes.dart';

part 'attributes_category_response.g.dart';

@JsonSerializable()
class AtributesCategoryResponse {
  String? id;
  String? slug;
  AtributesDescriptions? descriptions;
  List<AtributesValue>? values;

  AtributesCategoryResponse({
    this.id,
    this.slug,
    this.descriptions,
    this.values,
  });

  factory AtributesCategoryResponse.fromJson(Map<String, dynamic> json) {
    return _$AtributesCategoryResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AtributesCategoryResponseToJson(this);
  AtributesCategoryResponse copyWith({
    String? id,
    String? slug,
    AtributesDescriptions? descriptions,
    List<AtributesValue>? values,
  }) {
    return AtributesCategoryResponse(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      descriptions: descriptions ?? this.descriptions,
      values: values ?? this.values,
    );
  }
}
