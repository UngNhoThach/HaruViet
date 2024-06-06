// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasfiled.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TasfiledCWProxy {
  Tasfiled childs(List<Tas>? childs);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Tasfiled(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Tasfiled(...).copyWith(id: 12, name: "My name")
  /// ````
  Tasfiled call({
    List<Tas>? childs,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTasfiled.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTasfiled.copyWith.fieldName(...)`
class _$TasfiledCWProxyImpl implements _$TasfiledCWProxy {
  const _$TasfiledCWProxyImpl(this._value);

  final Tasfiled _value;

  @override
  Tasfiled childs(List<Tas>? childs) => this(childs: childs);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Tasfiled(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Tasfiled(...).copyWith(id: 12, name: "My name")
  /// ````
  Tasfiled call({
    Object? childs = const $CopyWithPlaceholder(),
  }) {
    return Tasfiled(
      childs: childs == const $CopyWithPlaceholder()
          ? _value.childs
          // ignore: cast_nullable_to_non_nullable
          : childs as List<Tas>?,
    );
  }
}

extension $TasfiledCopyWith on Tasfiled {
  /// Returns a callable class that can be used as follows: `instanceOfTasfiled.copyWith(...)` or like so:`instanceOfTasfiled.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TasfiledCWProxy get copyWith => _$TasfiledCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tasfiled _$TasfiledFromJson(Map<String, dynamic> json) => Tasfiled(
      childs: (json['Childs'] as List<dynamic>?)
          ?.map((e) => Tas.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TasfiledToJson(Tasfiled instance) => <String, dynamic>{
      'Childs': instance.childs?.map((e) => e.toJson()).toList(),
    };
