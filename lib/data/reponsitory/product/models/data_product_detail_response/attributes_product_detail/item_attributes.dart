import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/attributes_product_detail/value_attributes.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_attributes.g.dart';

@JsonSerializable()
class ItemAttributes {
  @JsonKey(name: 'attribute_id')
  String? attributeId;
  String? title;
  List<ValueAttributes>? values;

  ItemAttributes({this.attributeId, this.title, this.values});

  factory ItemAttributes.fromJson(Map<String, dynamic> json) =>
      _$ItemAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$ItemAttributesToJson(this);
}
