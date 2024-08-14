// ignore_for_file: await_only_futures

import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/theme/app_color.dart';
import 'package:haruviet/theme/app_color_scheme.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension UIContext on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  //TextTheme get textTheme => Theme.of(this).textTheme;
  ThemeData get theme => Theme.of(this);
  AppColor get appColor => AppColor(this);
  AppColorScheme get appColorScheme => AppColorScheme(this);

  void hideKeyboard() => FocusScope.of(this).unfocus();
}

extension Navigation on BuildContext {
  /// Wrapper of Get navigation /// We don't depend on Get to make them decouple and easy to maintain later extension Navigation on BuildContext {
  void justBack() {
    _doBack<void>();
  }

  void back<T>({
    T? result,
    bool closeOverlays = false,
    bool canPop = true,
    int? id,
  }) {
    _doBack<T>(
      result: result,
      closeOverlays: closeOverlays,
      canPop: canPop,
      id: id,
    );
  }

  void backUntilFirst() {
    Navigator.of(this).popUntil((route) => route.isFirst);
  }

  void _doBack<T>({
    T? result,
    bool closeOverlays = false,
    bool canPop = true,
    int? id,
  }) {
    Navigator.of(this).pop<T>(result);
  }

  void justOffNamed(String page) {
    _doOffNamed<void>(page);
  }

  void offNamedUntil(String page, String untilPage) {
    _doOffNamed<void>(page);
  }

  Future<T?>? offNamed<T>(
    String page, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) {
    return _doOffNamed<T>(
      page,
      arguments: arguments,
      id: id,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
    );
  }

  Future<T?>? _doOffNamed<T>(
    String page, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) {
    return Navigator.of(this).popAndPushNamed<T?, dynamic>(
      page,
      arguments: arguments,
    );
  }

  Future<dynamic>? justToNamed(String page) {
    return _toNamed<dynamic>(page);
  }

  Future<T?>? toNamed<T>(
    String page, {
    dynamic arguments,
  }) {
    return _toNamed<T>(
      page,
      arguments: arguments,
    );
  }

  Future<T?>? _toNamed<T>(
    String page, {
    dynamic arguments,
  }) {
    return Navigator.of(this).pushNamed<T>(
      page,
      arguments: arguments,
    );
  }

  dynamic get arguments => ModalRoute.of(this)?.settings.arguments;
}
