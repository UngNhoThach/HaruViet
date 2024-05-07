// ignore_for_file: await_only_futures

import 'package:eco_app/helper/colors.dart';
import 'package:eco_app/theme/app_color.dart';
import 'package:eco_app/theme/app_color_scheme.dart';
import 'package:eco_app/theme/typography.dart';
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

Future<void> showDialogActionSheet(
  BuildContext context, {
  required TextEditingController textEditingController,
  required String title,
  String confirmButtonLabel = 'Gửi',
  String cancelButtonLabel = 'Thoát',
  required String hintText,
  required VoidCallback onConfirm,
  bool isDestructiveAction = true,
  VoidCallback? onCancel,
}) async {
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Text(title),
        content: TextField(
          controller: textEditingController,
          decoration: InputDecoration(hintText: hintText),
          maxLines: null,
          keyboardType: TextInputType.multiline,
        ),
        actions: <Widget>[
          TextButton(
            child: Text(cancelButtonLabel),
            onPressed: () {
              onCancel?.call();
              // Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text(
              confirmButtonLabel,
            ),
            onPressed: () {
              onConfirm.call();
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

Future<void> showConfirmActionSheet(
  BuildContext context, {
  required String message,
  String confirmButtonLabel = 'Xóa',
  String cancelButtonLabel = 'Hủy',
  required VoidCallback onConfirm,
  bool isDestructiveAction = true,
  VoidCallback? onCancel,
}) async {
  await showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      message: Text(
        message,
        style: textTheme.bodyMedium,
      ),
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () {
          onCancel?.call();
          Navigator.pop(context);
        },
        child: Text(
          cancelButtonLabel,
          style: textTheme.bodyMedium,
        ),
      ),
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          isDestructiveAction: isDestructiveAction,
          onPressed: () {
            Navigator.pop(context);
            onConfirm.call();
          },
          child: Text(
            confirmButtonLabel,
            style: textTheme.bodyMedium?.copyWith(
              color: isDestructiveAction ? colorMain : colorBlack,
            ),
          ),
        )
      ],
    ),
  );
}
