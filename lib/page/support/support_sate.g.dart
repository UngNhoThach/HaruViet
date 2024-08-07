// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_sate.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SupportStateCWProxy {
  SupportState viewState(ViewState viewState);

  SupportState errorMsg(String errorMsg);

  SupportState isLoading(bool isLoading);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SupportState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SupportState(...).copyWith(id: 12, name: "My name")
  /// ````
  SupportState call({
    ViewState? viewState,
    String? errorMsg,
    bool? isLoading,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSupportState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSupportState.copyWith.fieldName(...)`
class _$SupportStateCWProxyImpl implements _$SupportStateCWProxy {
  const _$SupportStateCWProxyImpl(this._value);

  final SupportState _value;

  @override
  SupportState viewState(ViewState viewState) => this(viewState: viewState);

  @override
  SupportState errorMsg(String errorMsg) => this(errorMsg: errorMsg);

  @override
  SupportState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SupportState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SupportState(...).copyWith(id: 12, name: "My name")
  /// ````
  SupportState call({
    Object? viewState = const $CopyWithPlaceholder(),
    Object? errorMsg = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
  }) {
    return SupportState(
      viewState: viewState == const $CopyWithPlaceholder() || viewState == null
          ? _value.viewState
          // ignore: cast_nullable_to_non_nullable
          : viewState as ViewState,
      errorMsg: errorMsg == const $CopyWithPlaceholder() || errorMsg == null
          ? _value.errorMsg
          // ignore: cast_nullable_to_non_nullable
          : errorMsg as String,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
    );
  }
}

extension $SupportStateCopyWith on SupportState {
  /// Returns a callable class that can be used as follows: `instanceOfSupportState.copyWith(...)` or like so:`instanceOfSupportState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SupportStateCWProxy get copyWith => _$SupportStateCWProxyImpl(this);
}
