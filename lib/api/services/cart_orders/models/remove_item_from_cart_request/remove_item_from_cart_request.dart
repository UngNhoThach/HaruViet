import 'package:json_annotation/json_annotation.dart';

part 'remove_item_from_cart_request.g.dart';

@JsonSerializable()
class RemoveItemFromCartRequest {
  String? rowId;
  String? id;
  @JsonKey(name: 'new_qty')
  int? newQty;

  RemoveItemFromCartRequest({this.rowId, this.id, this.newQty});

  factory RemoveItemFromCartRequest.fromJson(Map<String, dynamic> json) {
    return _$RemoveItemFromCartRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RemoveItemFromCartRequestToJson(this);
}
