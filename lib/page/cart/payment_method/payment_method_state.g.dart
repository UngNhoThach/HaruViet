// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PaymentMethodStateCWProxy {
  PaymentMethodState viewState(ViewState viewState);

  PaymentMethodState errorMsg(String errorMsg);

  PaymentMethodState indexShippingMethod(int indexShippingMethod);

  PaymentMethodState isLoading(bool isLoading);

  PaymentMethodState methodNames(List<String> methodNames);

  PaymentMethodState valueShipping(String? valueShipping);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PaymentMethodState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PaymentMethodState(...).copyWith(id: 12, name: "My name")
  /// ````
  PaymentMethodState call({
    ViewState? viewState,
    String? errorMsg,
    int? indexShippingMethod,
    bool? isLoading,
    List<String>? methodNames,
    String? valueShipping,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPaymentMethodState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPaymentMethodState.copyWith.fieldName(...)`
class _$PaymentMethodStateCWProxyImpl implements _$PaymentMethodStateCWProxy {
  const _$PaymentMethodStateCWProxyImpl(this._value);

  final PaymentMethodState _value;

  @override
  PaymentMethodState viewState(ViewState viewState) =>
      this(viewState: viewState);

  @override
  PaymentMethodState errorMsg(String errorMsg) => this(errorMsg: errorMsg);

  @override
  PaymentMethodState indexShippingMethod(int indexShippingMethod) =>
      this(indexShippingMethod: indexShippingMethod);

  @override
  PaymentMethodState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  PaymentMethodState methodNames(List<String> methodNames) =>
      this(methodNames: methodNames);

  @override
  PaymentMethodState valueShipping(String? valueShipping) =>
      this(valueShipping: valueShipping);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PaymentMethodState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PaymentMethodState(...).copyWith(id: 12, name: "My name")
  /// ````
  PaymentMethodState call({
    Object? viewState = const $CopyWithPlaceholder(),
    Object? errorMsg = const $CopyWithPlaceholder(),
    Object? indexShippingMethod = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? methodNames = const $CopyWithPlaceholder(),
    Object? valueShipping = const $CopyWithPlaceholder(),
  }) {
    return PaymentMethodState(
      viewState: viewState == const $CopyWithPlaceholder() || viewState == null
          ? _value.viewState
          // ignore: cast_nullable_to_non_nullable
          : viewState as ViewState,
      errorMsg: errorMsg == const $CopyWithPlaceholder() || errorMsg == null
          ? _value.errorMsg
          // ignore: cast_nullable_to_non_nullable
          : errorMsg as String,
      indexShippingMethod:
          indexShippingMethod == const $CopyWithPlaceholder() ||
                  indexShippingMethod == null
              ? _value.indexShippingMethod
              // ignore: cast_nullable_to_non_nullable
              : indexShippingMethod as int,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      methodNames:
          methodNames == const $CopyWithPlaceholder() || methodNames == null
              ? _value.methodNames
              // ignore: cast_nullable_to_non_nullable
              : methodNames as List<String>,
      valueShipping: valueShipping == const $CopyWithPlaceholder()
          ? _value.valueShipping
          // ignore: cast_nullable_to_non_nullable
          : valueShipping as String?,
    );
  }
}

extension $PaymentMethodStateCopyWith on PaymentMethodState {
  /// Returns a callable class that can be used as follows: `instanceOfPaymentMethodState.copyWith(...)` or like so:`instanceOfPaymentMethodState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PaymentMethodStateCWProxy get copyWith =>
      _$PaymentMethodStateCWProxyImpl(this);
}
