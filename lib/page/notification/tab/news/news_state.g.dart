// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NewsStateCWProxy {
  NewsState viewState(ViewState viewState);

  NewsState errorMsg(String errorMsg);

  NewsState isSubmitSuccess(bool isSubmitSuccess);

  NewsState listNews(List<NewsResponse>? listNews);

  NewsState isLoading(bool isLoading);

  NewsState userInfoLogin(UserInfoLogin? userInfoLogin);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NewsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NewsState(...).copyWith(id: 12, name: "My name")
  /// ````
  NewsState call({
    ViewState? viewState,
    String? errorMsg,
    bool? isSubmitSuccess,
    List<NewsResponse>? listNews,
    bool? isLoading,
    UserInfoLogin? userInfoLogin,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNewsState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNewsState.copyWith.fieldName(...)`
class _$NewsStateCWProxyImpl implements _$NewsStateCWProxy {
  const _$NewsStateCWProxyImpl(this._value);

  final NewsState _value;

  @override
  NewsState viewState(ViewState viewState) => this(viewState: viewState);

  @override
  NewsState errorMsg(String errorMsg) => this(errorMsg: errorMsg);

  @override
  NewsState isSubmitSuccess(bool isSubmitSuccess) =>
      this(isSubmitSuccess: isSubmitSuccess);

  @override
  NewsState listNews(List<NewsResponse>? listNews) => this(listNews: listNews);

  @override
  NewsState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  NewsState userInfoLogin(UserInfoLogin? userInfoLogin) =>
      this(userInfoLogin: userInfoLogin);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NewsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NewsState(...).copyWith(id: 12, name: "My name")
  /// ````
  NewsState call({
    Object? viewState = const $CopyWithPlaceholder(),
    Object? errorMsg = const $CopyWithPlaceholder(),
    Object? isSubmitSuccess = const $CopyWithPlaceholder(),
    Object? listNews = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? userInfoLogin = const $CopyWithPlaceholder(),
  }) {
    return NewsState(
      viewState: viewState == const $CopyWithPlaceholder() || viewState == null
          ? _value.viewState
          // ignore: cast_nullable_to_non_nullable
          : viewState as ViewState,
      errorMsg: errorMsg == const $CopyWithPlaceholder() || errorMsg == null
          ? _value.errorMsg
          // ignore: cast_nullable_to_non_nullable
          : errorMsg as String,
      isSubmitSuccess: isSubmitSuccess == const $CopyWithPlaceholder() ||
              isSubmitSuccess == null
          ? _value.isSubmitSuccess
          // ignore: cast_nullable_to_non_nullable
          : isSubmitSuccess as bool,
      listNews: listNews == const $CopyWithPlaceholder()
          ? _value.listNews
          // ignore: cast_nullable_to_non_nullable
          : listNews as List<NewsResponse>?,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      userInfoLogin: userInfoLogin == const $CopyWithPlaceholder()
          ? _value.userInfoLogin
          // ignore: cast_nullable_to_non_nullable
          : userInfoLogin as UserInfoLogin?,
    );
  }
}

extension $NewsStateCopyWith on NewsState {
  /// Returns a callable class that can be used as follows: `instanceOfNewsState.copyWith(...)` or like so:`instanceOfNewsState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NewsStateCWProxy get copyWith => _$NewsStateCWProxyImpl(this);
}
