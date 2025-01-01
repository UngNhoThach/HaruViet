// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_base_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ItemBaseResponseCWProxy {
  ItemBaseResponse id(int? id);

  ItemBaseResponse morong(String? morong);

  ItemBaseResponse code(String? code);

  ItemBaseResponse keyword(String? keyword);

  ItemBaseResponse name(String? name);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ItemBaseResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ItemBaseResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  ItemBaseResponse call({
    int? id,
    String? morong,
    String? code,
    String? keyword,
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
  ItemBaseResponse morong(String? morong) => this(morong: morong);

  @override
  ItemBaseResponse code(String? code) => this(code: code);

  @override
  ItemBaseResponse keyword(String? keyword) => this(keyword: keyword);

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
    Object? morong = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? keyword = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return ItemBaseResponse(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      morong: morong == const $CopyWithPlaceholder()
          ? _value.morong
          // ignore: cast_nullable_to_non_nullable
          : morong as String?,
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String?,
      keyword: keyword == const $CopyWithPlaceholder()
          ? _value.keyword
          // ignore: cast_nullable_to_non_nullable
          : keyword as String?,
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
      id: (json['id'] as num?)?.toInt(),
      morong: json['morong'] as String?,
      code: json['code'] as String?,
      keyword: json['keyword'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ItemBaseResponseToJson(ItemBaseResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'morong': instance.morong,
      'code': instance.code,
      'name': instance.name,
      'keyword': instance.keyword,
    };
