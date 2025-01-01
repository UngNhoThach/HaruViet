// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_info_message.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FileInfoMessageCWProxy {
  FileInfoMessage fileFormat(String? fileFormat);

  FileInfoMessage fileName(String? fileName);

  FileInfoMessage filePath(String? filePath);

  FileInfoMessage fileStatus(String? fileStatus);

  FileInfoMessage fileSize(String? fileSize);

  FileInfoMessage thumb(String? thumb);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FileInfoMessage(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FileInfoMessage(...).copyWith(id: 12, name: "My name")
  /// ````
  FileInfoMessage call({
    String? fileFormat,
    String? fileName,
    String? filePath,
    String? fileStatus,
    String? fileSize,
    String? thumb,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfFileInfoMessage.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfFileInfoMessage.copyWith.fieldName(...)`
class _$FileInfoMessageCWProxyImpl implements _$FileInfoMessageCWProxy {
  const _$FileInfoMessageCWProxyImpl(this._value);

  final FileInfoMessage _value;

  @override
  FileInfoMessage fileFormat(String? fileFormat) =>
      this(fileFormat: fileFormat);

  @override
  FileInfoMessage fileName(String? fileName) => this(fileName: fileName);

  @override
  FileInfoMessage filePath(String? filePath) => this(filePath: filePath);

  @override
  FileInfoMessage fileStatus(String? fileStatus) =>
      this(fileStatus: fileStatus);

  @override
  FileInfoMessage fileSize(String? fileSize) => this(fileSize: fileSize);

  @override
  FileInfoMessage thumb(String? thumb) => this(thumb: thumb);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FileInfoMessage(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FileInfoMessage(...).copyWith(id: 12, name: "My name")
  /// ````
  FileInfoMessage call({
    Object? fileFormat = const $CopyWithPlaceholder(),
    Object? fileName = const $CopyWithPlaceholder(),
    Object? filePath = const $CopyWithPlaceholder(),
    Object? fileStatus = const $CopyWithPlaceholder(),
    Object? fileSize = const $CopyWithPlaceholder(),
    Object? thumb = const $CopyWithPlaceholder(),
  }) {
    return FileInfoMessage(
      fileFormat: fileFormat == const $CopyWithPlaceholder()
          ? _value.fileFormat
          // ignore: cast_nullable_to_non_nullable
          : fileFormat as String?,
      fileName: fileName == const $CopyWithPlaceholder()
          ? _value.fileName
          // ignore: cast_nullable_to_non_nullable
          : fileName as String?,
      filePath: filePath == const $CopyWithPlaceholder()
          ? _value.filePath
          // ignore: cast_nullable_to_non_nullable
          : filePath as String?,
      fileStatus: fileStatus == const $CopyWithPlaceholder()
          ? _value.fileStatus
          // ignore: cast_nullable_to_non_nullable
          : fileStatus as String?,
      fileSize: fileSize == const $CopyWithPlaceholder()
          ? _value.fileSize
          // ignore: cast_nullable_to_non_nullable
          : fileSize as String?,
      thumb: thumb == const $CopyWithPlaceholder()
          ? _value.thumb
          // ignore: cast_nullable_to_non_nullable
          : thumb as String?,
    );
  }
}

extension $FileInfoMessageCopyWith on FileInfoMessage {
  /// Returns a callable class that can be used as follows: `instanceOfFileInfoMessage.copyWith(...)` or like so:`instanceOfFileInfoMessage.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FileInfoMessageCWProxy get copyWith => _$FileInfoMessageCWProxyImpl(this);
}
