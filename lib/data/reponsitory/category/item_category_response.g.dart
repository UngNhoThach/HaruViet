// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_category_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ItemCategoryResponseCWProxy {
  ItemCategoryResponse id(int? id);

  ItemCategoryResponse code(String? code);

  ItemCategoryResponse name(String? name);

  ItemCategoryResponse isCheck(bool isCheck);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ItemCategoryResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ItemCategoryResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  ItemCategoryResponse call({
    int? id,
    String? code,
    String? name,
    bool? isCheck,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfItemCategoryResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfItemCategoryResponse.copyWith.fieldName(...)`
class _$ItemCategoryResponseCWProxyImpl
    implements _$ItemCategoryResponseCWProxy {
  const _$ItemCategoryResponseCWProxyImpl(this._value);

  final ItemCategoryResponse _value;

  @override
  ItemCategoryResponse id(int? id) => this(id: id);

  @override
  ItemCategoryResponse code(String? code) => this(code: code);

  @override
  ItemCategoryResponse name(String? name) => this(name: name);

  @override
  ItemCategoryResponse isCheck(bool isCheck) => this(isCheck: isCheck);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ItemCategoryResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ItemCategoryResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  ItemCategoryResponse call({
    Object? id = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? isCheck = const $CopyWithPlaceholder(),
  }) {
    return ItemCategoryResponse(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      isCheck: isCheck == const $CopyWithPlaceholder() || isCheck == null
          ? _value.isCheck
          // ignore: cast_nullable_to_non_nullable
          : isCheck as bool,
    );
  }
}

extension $ItemCategoryResponseCopyWith on ItemCategoryResponse {
  /// Returns a callable class that can be used as follows: `instanceOfItemCategoryResponse.copyWith(...)` or like so:`instanceOfItemCategoryResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ItemCategoryResponseCWProxy get copyWith =>
      _$ItemCategoryResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemCategoryResponse _$ItemCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    ItemCategoryResponse(
      id: json['Id'] as int?,
      code: json['Code'] as String?,
      name: json['Name'] as String?,
      isCheck: json['isCheck'] as bool? ?? false,
    );

Map<String, dynamic> _$ItemCategoryResponseToJson(
        ItemCategoryResponse instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Code': instance.code,
      'Name': instance.name,
      'isCheck': instance.isCheck,
    };
