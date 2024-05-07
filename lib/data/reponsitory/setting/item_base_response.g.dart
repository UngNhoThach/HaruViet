// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_base_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ItemBaseResponseCWProxy {
  ItemBaseResponse id(int? id);

  ItemBaseResponse type(int? type);

  ItemBaseResponse code(String? code);

  ItemBaseResponse name(String? name);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ItemBaseResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ItemBaseResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  ItemBaseResponse call({
    int? id,
    int? type,
    String? code,
    String? name,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfItemBaseResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfItemBaseResponse.copyWith.fieldName(...)`
class _$ItemBaseResponseCWProxyImpl implements _$ItemBaseResponseCWProxy {
  const _$ItemBaseResponseCWProxyImpl(this._value);

  final ItemBaseResponse _value;

  @override
  ItemBaseResponse id(int? id) => this(id: id);

  @override
  ItemBaseResponse type(int? type) => this(type: type);

  @override
  ItemBaseResponse code(String? code) => this(code: code);

  @override
  ItemBaseResponse name(String? name) => this(name: name);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ItemBaseResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ItemBaseResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  ItemBaseResponse call({
    Object? id = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return ItemBaseResponse(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as int?,
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
    );
  }
}

extension $ItemBaseResponseCopyWith on ItemBaseResponse {
  /// Returns a callable class that can be used as follows: `instanceOfItemBaseResponse.copyWith(...)` or like so:`instanceOfItemBaseResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ItemBaseResponseCWProxy get copyWith => _$ItemBaseResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemBaseResponse _$ItemBaseResponseFromJson(Map<String, dynamic> json) =>
    ItemBaseResponse(
      id: json['Id'] as int?,
      type: json['Type'] as int?,
      code: json['Code'] as String?,
      name: json['Name'] as String?,
    );

Map<String, dynamic> _$ItemBaseResponseToJson(ItemBaseResponse instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Type': instance.type,
      'Code': instance.code,
      'Name': instance.name,
    };
