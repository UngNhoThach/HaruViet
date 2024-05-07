// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_history_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationHistoryResponseCWProxy {
  NotificationHistoryResponse id(int? id);

  NotificationHistoryResponse title(String? title);

  NotificationHistoryResponse description(String? description);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationHistoryResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationHistoryResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationHistoryResponse call({
    int? id,
    String? title,
    String? description,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNotificationHistoryResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNotificationHistoryResponse.copyWith.fieldName(...)`
class _$NotificationHistoryResponseCWProxyImpl
    implements _$NotificationHistoryResponseCWProxy {
  const _$NotificationHistoryResponseCWProxyImpl(this._value);

  final NotificationHistoryResponse _value;

  @override
  NotificationHistoryResponse id(int? id) => this(id: id);

  @override
  NotificationHistoryResponse title(String? title) => this(title: title);

  @override
  NotificationHistoryResponse description(String? description) =>
      this(description: description);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationHistoryResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationHistoryResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationHistoryResponse call({
    Object? id = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
  }) {
    return NotificationHistoryResponse(
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
    );
  }
}

extension $NotificationHistoryResponseCopyWith on NotificationHistoryResponse {
  /// Returns a callable class that can be used as follows: `instanceOfNotificationHistoryResponse.copyWith(...)` or like so:`instanceOfNotificationHistoryResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NotificationHistoryResponseCWProxy get copyWith =>
      _$NotificationHistoryResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationHistoryResponse _$NotificationHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationHistoryResponse(
      id: json['Id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$NotificationHistoryResponseToJson(
        NotificationHistoryResponse instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'title': instance.title,
      'description': instance.description,
    };
