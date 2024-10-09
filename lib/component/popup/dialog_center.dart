import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAlertDialog extends StatefulWidget {
  final String message;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final double? heightDialog;
  const CustomAlertDialog({
    Key? key,
    required this.message,
    required this.buttonText,
    required this.onButtonPressed,
    this.heightDialog,
  }) : super(key: key);

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      content: Builder(builder: (context) {
        return SizedBox(
          height: widget.heightDialog ?? 140.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              widget.heightDialog == null
                  ? SizedBox(
                      width: 80.w,
                      height: 80.h,
                    )
                  : SizedBox(
                      width: widget.heightDialog! - 30.w,
                      height: widget.heightDialog! - 30.h,
                    ),
              spaceH16,
              Text(
                widget.message,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }),
      actions: <Widget>[
        spaceH8,
        TextButton(
          onPressed: widget.onButtonPressed,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.r, vertical: 12.r),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                widget.buttonText,
                style: const TextStyle(color: colorWhite),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
