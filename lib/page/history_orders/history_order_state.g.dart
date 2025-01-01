// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_order_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HistoryOrderStateCWProxy {
  HistoryOrderState viewState(ViewState viewState);

  HistoryOrderState errorMsg(String errorMsg);

  HistoryOrderState listStatusOrder(List<DataStatusOrder>? listStatusOrder);

  HistoryOrderState idUser(String? idUser);

  HistoryOrderState isLoading(bool isLoading);

  HistoryOrderState tab(int tab);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HistoryOrderState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HistoryOrderState(...).copyWith(id: 12, name: "My name")
  /// ````
  HistoryOrderState call({
    ViewState? viewState,
    String? errorMsg,
    List<DataStatusOrder>? listStatusOrder,
    String? idUser,
    bool? isLoading,
    int? tab,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHistoryOrderState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHistoryOrderState.copyWith.fieldName(...)`
class _$HistoryOrderStateCWProxyImpl implements _$HistoryOrderStateCWProxy {
  const _$HistoryOrderStateCWProxyImpl(this._value);

  final HistoryOrderState _value;

  @override
  HistoryOrderState viewState(ViewState viewState) =>
      this(viewState: viewState);

  @override
  HistoryOrderState errorMsg(String errorMsg) => this(errorMsg: errorMsg);

  @override
  HistoryOrderState listStatusOrder(List<DataStatusOrder>? listStatusOrder) =>
      this(listStatusOrder: listStatusOrder);

  @override
  HistoryOrderState idUser(String? idUser) => this(idUser: idUser);

  @override
  HistoryOrderState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  HistoryOrderState tab(int tab) => this(tab: tab);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HistoryOrderState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HistoryOrderState(...).copyWith(id: 12, name: "My name")
  /// ````
  HistoryOrderState call({
    Object? viewState = const $CopyWithPlaceholder(),
    Object? errorMsg = const $CopyWithPlaceholder(),
    Object? listStatusOrder = const $CopyWithPlaceholder(),
    Object? idUser = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? tab = const $CopyWithPlaceholder(),
  }) {
    return HistoryOrderState(
      viewState: viewState == const $CopyWithPlaceholder() || viewState == null
          ? _value.viewState
          // ignore: cast_nullable_to_non_nullable
          : viewState as ViewState,
      errorMsg: errorMsg == const $CopyWithPlaceholder() || errorMsg == null
          ? _value.errorMsg
          // ignore: cast_nullable_to_non_nullable
          : errorMsg as String,
      listStatusOrder: listStatusOrder == const $CopyWithPlaceholder()
          ? _value.listStatusOrder
          // ignore: cast_nullable_to_non_nullable
          : listStatusOrder as List<DataStatusOrder>?,
      idUser: idUser == const $CopyWithPlaceholder()
          ? _value.idUser
          // ignore: cast_nullable_to_non_nullable
          : idUser as String?,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      tab: tab == const $CopyWithPlaceholder() || tab == null
          ? _value.tab
          // ignore: cast_nullable_to_non_nullable
          : tab as int,
    );
  }
}

extension $HistoryOrderStateCopyWith on HistoryOrderState {
  /// Returns a callable class that can be used as follows: `instanceOfHistoryOrderState.copyWith(...)` or like so:`instanceOfHistoryOrderState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HistoryOrderStateCWProxy get copyWith =>
      _$HistoryOrderStateCWProxyImpl(this);
}
