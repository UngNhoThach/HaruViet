// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tas.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TasCWProxy {
  Tas id(int? id);

  Tas title(String? title);

  Tas description(String? description);

  Tas startDate(DateTime? startDate);

  Tas isCompleted(bool? isCompleted);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Tas(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Tas(...).copyWith(id: 12, name: "My name")
  /// ````
  Tas call({
    int? id,
    String? title,
    String? description,
    DateTime? startDate,
    bool? isCompleted,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTas.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTas.copyWith.fieldName(...)`
class _$TasCWProxyImpl implements _$TasCWProxy {
  const _$TasCWProxyImpl(this._value);

  final Tas _value;

  @override
  Tas id(int? id) => this(id: id);

  @override
  Tas title(String? title) => this(title: title);

  @override
  Tas description(String? description) => this(description: description);

  @override
  Tas startDate(DateTime? startDate) => this(startDate: startDate);

  @override
  Tas isCompleted(bool? isCompleted) => this(isCompleted: isCompleted);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Tas(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Tas(...).copyWith(id: 12, name: "My name")
  /// ````
  Tas call({
    Object? id = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? startDate = const $CopyWithPlaceholder(),
    Object? isCompleted = const $CopyWithPlaceholder(),
  }) {
    return Tas(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      startDate: startDate == const $CopyWithPlaceholder()
          ? _value.startDate
          // ignore: cast_nullable_to_non_nullable
          : startDate as DateTime?,
      isCompleted: isCompleted == const $CopyWithPlaceholder()
          ? _value.isCompleted
          // ignore: cast_nullable_to_non_nullable
          : isCompleted as bool?,
    );
  }
}

extension $TasCopyWith on Tas {
  /// Returns a callable class that can be used as follows: `instanceOfTas.copyWith(...)` or like so:`instanceOfTas.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TasCWProxy get copyWith => _$TasCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tas _$TasFromJson(Map<String, dynamic> json) => Tas(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      isCompleted: json['isCompleted'] as bool?,
    );

Map<String, dynamic> _$TasToJson(Tas instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'startDate': instance.startDate?.toIso8601String(),
      'isCompleted': instance.isCompleted,
    };
