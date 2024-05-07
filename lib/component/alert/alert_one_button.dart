import 'package:flutter/cupertino.dart';

class CustomCupertinoAlertOneButton extends StatefulWidget {
  final String? title;
  final String content;
  final String? positiveButtonText;
  final VoidCallback onPositiveButtonPressed;

  const CustomCupertinoAlertOneButton({
    Key? key,
    this.title,
    required this.content,
    this.positiveButtonText,
    required this.onPositiveButtonPressed,
  }) : super(key: key);

  @override
  _CustomCupertinoAlertOneButtonState createState() =>
      _CustomCupertinoAlertOneButtonState();
}

class _CustomCupertinoAlertOneButtonState
    extends State<CustomCupertinoAlertOneButton> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(widget.title ?? 'Thông báo'),
      content: Text(widget.content),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          onPressed: widget.onPositiveButtonPressed,
          child: Text(widget.positiveButtonText ?? 'Đồng ý'),
        ),
      ],
    );
  }
}
