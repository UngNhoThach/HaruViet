// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_address_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SelectAddressStateCWProxy {
  SelectAddressState viewState(ViewState viewState);

  SelectAddressState errorMsg(String errorMsg);

  SelectAddressState step(SelectAddressStep? step);

  SelectAddressState isLoading(bool isLoading);

  SelectAddressState isSelect(bool isSelect);

  SelectAddressState dataList(List<ItemBaseResponse> dataList);

  SelectAddressState dataSearchList(List<ItemBaseResponse> dataSearchList);

  SelectAddressState dataAddress(AddressResponse dataAddress);

  SelectAddressState isSubmitSuccess(bool isSubmitSuccess);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SelectAddressState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SelectAddressState(...).copyWith(id: 12, name: "My name")
  /// ````
  SelectAddressState call({
    ViewState? viewState,
    String? errorMsg,
    SelectAddressStep? step,
    bool? isLoading,
    bool? isSelect,
    List<ItemBaseResponse>? dataList,
    List<ItemBaseResponse>? dataSearchList,
    AddressResponse? dataAddress,
    bool? isSubmitSuccess,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSelectAddressState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSelectAddressState.copyWith.fieldName(...)`
class _$SelectAddressStateCWProxyImpl implements _$SelectAddressStateCWProxy {
  const _$SelectAddressStateCWProxyImpl(this._value);

  final SelectAddressState _value;

  @override
  SelectAddressState viewState(ViewState viewState) =>
      this(viewState: viewState);

  @override
  SelectAddressState errorMsg(String errorMsg) => this(errorMsg: errorMsg);

  @override
  SelectAddressState step(SelectAddressStep? step) => this(step: step);

  @override
  SelectAddressState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  SelectAddressState isSelect(bool isSelect) => this(isSelect: isSelect);

  @override
  SelectAddressState dataList(List<ItemBaseResponse> dataList) =>
      this(dataList: dataList);

  @override
  SelectAddressState dataSearchList(List<ItemBaseResponse> dataSearchList) =>
      this(dataSearchList: dataSearchList);

  @override
  SelectAddressState dataAddress(AddressResponse dataAddress) =>
      this(dataAddress: dataAddress);

  @override
  SelectAddressState isSubmitSuccess(bool isSubmitSuccess) =>
      this(isSubmitSuccess: isSubmitSuccess);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SelectAddressState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SelectAddressState(...).copyWith(id: 12, name: "My name")
  /// ````
  SelectAddressState call({
    Object? viewState = const $CopyWithPlaceholder(),
    Object? errorMsg = const $CopyWithPlaceholder(),
    Object? step = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? isSelect = const $CopyWithPlaceholder(),
    Object? dataList = const $CopyWithPlaceholder(),
    Object? dataSearchList = const $CopyWithPlaceholder(),
    Object? dataAddress = const $CopyWithPlaceholder(),
    Object? isSubmitSuccess = const $CopyWithPlaceholder(),
  }) {
    return SelectAddressState(
      viewState: viewState == const $CopyWithPlaceholder() || viewState == null
          ? _value.viewState
          // ignore: cast_nullable_to_non_nullable
          : viewState as ViewState,
      errorMsg: errorMsg == const $CopyWithPlaceholder() || errorMsg == null
          ? _value.errorMsg
          // ignore: cast_nullable_to_non_nullable
          : errorMsg as String,
      step: step == const $CopyWithPlaceholder()
          ? _value.step
          // ignore: cast_nullable_to_non_nullable
          : step as SelectAddressStep?,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      isSelect: isSelect == const $CopyWithPlaceholder() || isSelect == null
          ? _value.isSelect
          // ignore: cast_nullable_to_non_nullable
          : isSelect as bool,
      dataList: dataList == const $CopyWithPlaceholder() || dataList == null
          ? _value.dataList
          // ignore: cast_nullable_to_non_nullable
          : dataList as List<ItemBaseResponse>,
      dataSearchList: dataSearchList == const $CopyWithPlaceholder() ||
              dataSearchList == null
          ? _value.dataSearchList
          // ignore: cast_nullable_to_non_nullable
          : dataSearchList as List<ItemBaseResponse>,
      dataAddress:
          dataAddress == const $CopyWithPlaceholder() || dataAddress == null
              ? _value.dataAddress
              // ignore: cast_nullable_to_non_nullable
              : dataAddress as AddressResponse,
      isSubmitSuccess: isSubmitSuccess == const $CopyWithPlaceholder() ||
              isSubmitSuccess == null
          ? _value.isSubmitSuccess
          // ignore: cast_nullable_to_non_nullable
          : isSubmitSuccess as bool,
    );
  }
}

extension $SelectAddressStateCopyWith on SelectAddressState {
  /// Returns a callable class that can be used as follows: `instanceOfSelectAddressState.copyWith(...)` or like so:`instanceOfSelectAddressState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SelectAddressStateCWProxy get copyWith =>
      _$SelectAddressStateCWProxyImpl(this);
}
