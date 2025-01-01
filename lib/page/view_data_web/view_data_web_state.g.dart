// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_data_web_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ViewDataWebStateCWProxy {
  ViewDataWebState viewState(ViewState viewState);

  ViewDataWebState errorMsg(String errorMsg);

  ViewDataWebState isLoading(bool isLoading);

  ViewDataWebState controller(WebViewController? controller);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ViewDataWebState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ViewDataWebState(...).copyWith(id: 12, name: "My name")
  /// ````
  ViewDataWebState call({
    ViewState? viewState,
    String? errorMsg,
    bool? isLoading,
    WebViewController? controller,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfViewDataWebState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfViewDataWebState.copyWith.fieldName(...)`
class _$ViewDataWebStateCWProxyImpl implements _$ViewDataWebStateCWProxy {
  const _$ViewDataWebStateCWProxyImpl(this._value);

  final ViewDataWebState _value;

  @override
  ViewDataWebState viewState(ViewState viewState) => this(viewState: viewState);

  @override
  ViewDataWebState errorMsg(String errorMsg) => this(errorMsg: errorMsg);

  @override
  ViewDataWebState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  ViewDataWebState controller(WebViewController? controller) =>
      this(controller: controller);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ViewDataWebState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ViewDataWebState(...).copyWith(id: 12, name: "My name")
  /// ````
  ViewDataWebState call({
    Object? viewState = const $CopyWithPlaceholder(),
    Object? errorMsg = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? controller = const $CopyWithPlaceholder(),
  }) {
    return ViewDataWebState(
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
      controller: controller == const $CopyWithPlaceholder()
          ? _value.controller
          // ignore: cast_nullable_to_non_nullable
          : controller as WebViewController?,
    );
  }
}

extension $ViewDataWebStateCopyWith on ViewDataWebState {
  /// Returns a callable class that can be used as follows: `instanceOfViewDataWebState.copyWith(...)` or like so:`instanceOfViewDataWebState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ViewDataWebStateCWProxy get copyWith => _$ViewDataWebStateCWProxyImpl(this);
}
