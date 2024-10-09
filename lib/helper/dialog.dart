import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/theme/typography.dart';

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
              color: isDestructiveAction
                  ? Theme.of(context).primaryColor
                  : colorBlack,
            ),
          ),
        )
      ],
    ),
  );
}
