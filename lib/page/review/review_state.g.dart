// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReviewStateCWProxy {
  ReviewState viewState(ViewState viewState);

  ReviewState errorMsg(String errorMsg);

  ReviewState isLoading(bool isLoading);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReviewState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReviewState(...).copyWith(id: 12, name: "My name")
  /// ````
  ReviewState call({
    ViewState? viewState,
    String? errorMsg,
    bool? isLoading,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReviewState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReviewState.copyWith.fieldName(...)`
class _$ReviewStateCWProxyImpl implements _$ReviewStateCWProxy {
  const _$ReviewStateCWProxyImpl(this._value);

  final ReviewState _value;

  @override
  ReviewState viewState(ViewState viewState) => this(viewState: viewState);

  @override
  ReviewState errorMsg(String errorMsg) => this(errorMsg: errorMsg);

  @override
  ReviewState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReviewState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReviewState(...).copyWith(id: 12, name: "My name")
  /// ````
  ReviewState call({
    Object? viewState = const $CopyWithPlaceholder(),
    Object? errorMsg = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
  }) {
    return ReviewState(
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

extension $ReviewStateCopyWith on ReviewState {
  /// Returns a callable class that can be used as follows: `instanceOfReviewState.copyWith(...)` or like so:`instanceOfReviewState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReviewStateCWProxy get copyWith => _$ReviewStateCWProxyImpl(this);
}
