import 'package:json_annotation/json_annotation.dart';

import 'value.dart';

part 'attributes_get_cart_order.g.dart';

@JsonSerializable()
class AttributesGetCartOrder {
  String? id;
  String? type;
  @JsonKey(name: 'is_required')
  bool? isRequired;
  @JsonKey(name: 'is_global')
  bool? isGlobal;
  String? title;
  List<Value>? values;

  AttributesGetCartOrder({
    this.id,
    this.type,
    this.isRequired,
    this.isGlobal,
    this.title,
    this.values,
  });

  factory AttributesGetCartOrder.fromJson(Map<String, dynamic> json) {
    return _$AttributesGetCartOrderFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AttributesGetCartOrderToJson(this);
}
