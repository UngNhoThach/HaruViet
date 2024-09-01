import 'package:json_annotation/json_annotation.dart';

import 'item_attributes.dart';

part 'attributes_product_detail.g.dart';

@JsonSerializable()
class AttributesProductDetail {
  @JsonKey(name: 'attributesets_id')
  String? attributesetsId;
  String? title;
  List<ItemAttributes>? item;

  AttributesProductDetail({this.attributesetsId, this.title, this.item});

  factory AttributesProductDetail.fromJson(Map<String, dynamic> json) {
    return _$AttributesProductDetailFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AttributesProductDetailToJson(this);
}
