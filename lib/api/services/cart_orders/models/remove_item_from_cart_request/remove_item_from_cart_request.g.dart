// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remove_item_from_cart_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoveItemFromCartRequest _$RemoveItemFromCartRequestFromJson(
        Map<String, dynamic> json) =>
    RemoveItemFromCartRequest(
      rowId: json['rowId'] as String?,
      id: json['id'] as String?,
      newQty: (json['new_qty'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RemoveItemFromCartRequestToJson(
        RemoveItemFromCartRequest instance) =>
    <String, dynamic>{
      'rowId': instance.rowId,
      'id': instance.id,
      'new_qty': instance.newQty,
    };
