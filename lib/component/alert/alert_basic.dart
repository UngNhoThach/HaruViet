import 'package:flutter/cupertino.dart';

class CustomCupertinoAlertBasic extends StatefulWidget {
  final String? title;
  final String content;
  final String? negativeButtonText;
  final String? positiveButtonText;
  final VoidCallback? onNegativeButtonPressed;
  final VoidCallback onPositiveButtonPressed;

  const CustomCupertinoAlertBasic({
    Key? key,
    this.title,
    required this.content,
    this.negativeButtonText,
    this.positiveButtonText,
    required this.onNegativeButtonPressed,
    required this.onPositiveButtonPressed,
  }) : super(key: key);

  @override
  _CustomCupertinoAlertBasicState createState() =>
      _CustomCupertinoAlertBasicState();
}

class _CustomCupertinoAlertBasicState extends State<CustomCupertinoAlertBasic> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(widget.title ?? 'Thông báo'),
      content: Text(widget.content),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          onPressed: widget.onNegativeButtonPressed,
          child: Text(widget.negativeButtonText ?? 'Huỷ'),
        ),
        CupertinoDialogAction(
          onPressed: widget.onPositiveButtonPressed,
          child: Text(widget.positiveButtonText ?? 'Đồng ý'),
        ),
      ],
    );
  }
}
