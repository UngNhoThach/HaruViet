// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drawer_list_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DrawerListStateCWProxy {
  DrawerListState viewState(ViewState viewState);

  DrawerListState errorMsg(String errorMsg);

  DrawerListState listStatusOrder(List<DataStatusOrder> listStatusOrder);

  DrawerListState isLogin(bool isLogin);

  DrawerListState dataUser(UserState? dataUser);

  DrawerListState isLoading(bool isLoading);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DrawerListState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DrawerListState(...).copyWith(id: 12, name: "My name")
  /// ````
  DrawerListState call({
    ViewState? viewState,
    String? errorMsg,
    List<DataStatusOrder>? listStatusOrder,
    bool? isLogin,
    UserState? dataUser,
    bool? isLoading,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDrawerListState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDrawerListState.copyWith.fieldName(...)`
class _$DrawerListStateCWProxyImpl implements _$DrawerListStateCWProxy {
  const _$DrawerListStateCWProxyImpl(this._value);

  final DrawerListState _value;

  @override
  DrawerListState viewState(ViewState viewState) => this(viewState: viewState);

  @override
  DrawerListState errorMsg(String errorMsg) => this(errorMsg: errorMsg);

  @override
  DrawerListState listStatusOrder(List<DataStatusOrder> listStatusOrder) =>
      this(listStatusOrder: listStatusOrder);

  @override
  DrawerListState isLogin(bool isLogin) => this(isLogin: isLogin);

  @override
  DrawerListState dataUser(UserState? dataUser) => this(dataUser: dataUser);

  @override
  DrawerListState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DrawerListState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DrawerListState(...).copyWith(id: 12, name: "My name")
  /// ````
  DrawerListState call({
    Object? viewState = const $CopyWithPlaceholder(),
    Object? errorMsg = const $CopyWithPlaceholder(),
    Object? listStatusOrder = const $CopyWithPlaceholder(),
    Object? isLogin = const $CopyWithPlaceholder(),
    Object? dataUser = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
  }) {
    return DrawerListState(
      viewState: viewState == const $CopyWithPlaceholder() || viewState == null
          ? _value.viewState
          // ignore: cast_nullable_to_non_nullable
          : viewState as ViewState,
      errorMsg: errorMsg == const $CopyWithPlaceholder() || errorMsg == null
          ? _value.errorMsg
          // ignore: cast_nullable_to_non_nullable
          : errorMsg as String,
      listStatusOrder: listStatusOrder == const $CopyWithPlaceholder() ||
              listStatusOrder == null
          ? _value.listStatusOrder
          // ignore: cast_nullable_to_non_nullable
          : listStatusOrder as List<DataStatusOrder>,
      isLogin: isLogin == const $CopyWithPlaceholder() || isLogin == null
          ? _value.isLogin
          // ignore: cast_nullable_to_non_nullable
          : isLogin as bool,
      dataUser: dataUser == const $CopyWithPlaceholder()
          ? _value.dataUser
          // ignore: cast_nullable_to_non_nullable
          : dataUser as UserState?,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
    );
  }
}

extension $DrawerListStateCopyWith on DrawerListState {
  /// Returns a callable class that can be used as follows: `instanceOfDrawerListState.copyWith(...)` or like so:`instanceOfDrawerListState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DrawerListStateCWProxy get copyWith => _$DrawerListStateCWProxyImpl(this);
}
