// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NewsResponseCWProxy {
  NewsResponse id(int? id);

  NewsResponse title(String? title);

  NewsResponse description(String? description);

  NewsResponse location(String? location);

  NewsResponse time(String? time);

  NewsResponse image(String? image);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NewsResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NewsResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  NewsResponse call({
    int? id,
    String? title,
    String? description,
    String? location,
    String? time,
    String? image,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNewsResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNewsResponse.copyWith.fieldName(...)`
class _$NewsResponseCWProxyImpl implements _$NewsResponseCWProxy {
  const _$NewsResponseCWProxyImpl(this._value);

  final NewsResponse _value;

  @override
  NewsResponse id(int? id) => this(id: id);

  @override
  NewsResponse title(String? title) => this(title: title);

  @override
  NewsResponse description(String? description) =>
      this(description: description);

  @override
  NewsResponse location(String? location) => this(location: location);

  @override
  NewsResponse time(String? time) => this(time: time);

  @override
  NewsResponse image(String? image) => this(image: image);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NewsResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NewsResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  NewsResponse call({
    Object? id = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? location = const $CopyWithPlaceholder(),
    Object? time = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
  }) {
    return NewsResponse(
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
      location: location == const $CopyWithPlaceholder()
          ? _value.location
          // ignore: cast_nullable_to_non_nullable
          : location as String?,
      time: time == const $CopyWithPlaceholder()
          ? _value.time
          // ignore: cast_nullable_to_non_nullable
          : time as String?,
      image: image == const $CopyWithPlaceholder()
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String?,
    );
  }
}

extension $NewsResponseCopyWith on NewsResponse {
  /// Returns a callable class that can be used as follows: `instanceOfNewsResponse.copyWith(...)` or like so:`instanceOfNewsResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NewsResponseCWProxy get copyWith => _$NewsResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsResponse _$NewsResponseFromJson(Map<String, dynamic> json) => NewsResponse(
      id: json['Id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      location: json['location'] as String?,
      time: json['time'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$NewsResponseToJson(NewsResponse instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'image': instance.image,
      'title': instance.title,
      'description': instance.description,
      'location': instance.location,
      'time': instance.time,
    };
