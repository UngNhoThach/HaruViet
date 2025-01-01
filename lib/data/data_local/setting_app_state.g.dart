// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_app_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SettingAppStateCWProxy {
  SettingAppState xName(String? xName);

  SettingAppState xApiKey(String? xApiKey);

  SettingAppState xUrl(String? xUrl);

  SettingAppState xPoweredBy(String? xPoweredBy);

  SettingAppState date(String? date);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SettingAppState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SettingAppState(...).copyWith(id: 12, name: "My name")
  /// ````
  SettingAppState call({
    String? xName,
    String? xApiKey,
    String? xUrl,
    String? xPoweredBy,
    String? date,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSettingAppState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSettingAppState.copyWith.fieldName(...)`
class _$SettingAppStateCWProxyImpl implements _$SettingAppStateCWProxy {
  const _$SettingAppStateCWProxyImpl(this._value);

  final SettingAppState _value;

  @override
  SettingAppState xName(String? xName) => this(xName: xName);

  @override
  SettingAppState xApiKey(String? xApiKey) => this(xApiKey: xApiKey);

  @override
  SettingAppState xUrl(String? xUrl) => this(xUrl: xUrl);

  @override
  SettingAppState xPoweredBy(String? xPoweredBy) =>
      this(xPoweredBy: xPoweredBy);

  @override
  SettingAppState date(String? date) => this(date: date);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SettingAppState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SettingAppState(...).copyWith(id: 12, name: "My name")
  /// ````
  SettingAppState call({
    Object? xName = const $CopyWithPlaceholder(),
    Object? xApiKey = const $CopyWithPlaceholder(),
    Object? xUrl = const $CopyWithPlaceholder(),
    Object? xPoweredBy = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
  }) {
    return SettingAppState(
      xName: xName == const $CopyWithPlaceholder()
          ? _value.xName
          // ignore: cast_nullable_to_non_nullable
          : xName as String?,
      xApiKey: xApiKey == const $CopyWithPlaceholder()
          ? _value.xApiKey
          // ignore: cast_nullable_to_non_nullable
          : xApiKey as String?,
      xUrl: xUrl == const $CopyWithPlaceholder()
          ? _value.xUrl
          // ignore: cast_nullable_to_non_nullable
          : xUrl as String?,
      xPoweredBy: xPoweredBy == const $CopyWithPlaceholder()
          ? _value.xPoweredBy
          // ignore: cast_nullable_to_non_nullable
          : xPoweredBy as String?,
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as String?,
    );
  }
}

extension $SettingAppStateCopyWith on SettingAppState {
  /// Returns a callable class that can be used as follows: `instanceOfSettingAppState.copyWith(...)` or like so:`instanceOfSettingAppState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SettingAppStateCWProxy get copyWith => _$SettingAppStateCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingAppState _$SettingAppStateFromJson(Map<String, dynamic> json) =>
    SettingAppState(
      xName: json['X-Name'] as String?,
      xApiKey: json['X-ApiKey'] as String?,
      xUrl: json['X-Url'] as String?,
      xPoweredBy: json['X-Powered-By'] as String?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$SettingAppStateToJson(SettingAppState instance) =>
    <String, dynamic>{
      'X-Name': instance.xName,
      'X-ApiKey': instance.xApiKey,
      'X-Url': instance.xUrl,
      'X-Powered-By': instance.xPoweredBy,
      'date': instance.date,
    };
