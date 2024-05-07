import 'package:eco_app/helper/context.dart';
import 'package:eco_app/helper/shadows.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helper/spaces.dart';

class BottomBarButton extends StatelessWidget {
  const BottomBarButton({
    super.key,
    required this.button1,
    this.button2,
    this.widgetOnButton,
  });

  final Widget button1;
  final Widget? button2;
  final Widget? widgetOnButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        boxShadow: shadowE1,
        color: context.appColor.colorWhite,
      ),
      child: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widgetOnButton != null) ...[
              widgetOnButton!,
            ],
            Row(
              children: [
                Expanded(
                  child: button1,
                ),
                if (button2 != null) ...[
                  spaceW16,
                  Expanded(
                    child: button2!,
                  ),
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BottomBarButton2Widget extends StatefulWidget {
  final String buttonContent;
  final String dialogContent;
  final String dialogTitle;
  final TextEditingController textEditingController;
  final dynamic buttonAction;
  final Color buttonColor;
  final Color textColor;
  const BottomBarButton2Widget({
    super.key,
    required this.buttonContent,
    required this.buttonAction,
    required this.buttonColor,
    required this.textColor,
    required this.dialogContent,
    required this.dialogTitle,
    required this.textEditingController,
  });

  @override
  State<BottomBarButton2Widget> createState() => _BottomBarButton2WidgetState();
}

class _BottomBarButton2WidgetState extends State<BottomBarButton2Widget> {
  bool _isLoading = false;

  void _handleButtonPress() {
    // widget.buttonAction();
    _displayDialog(context);
    setState(() {
      _isLoading = true;
    });
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(widget.dialogTitle),
          content: TextField(
            controller: widget.textEditingController,
            decoration: InputDecoration(hintText: widget.dialogContent),
            maxLines:
                null, // or set it to a specific number for a limited number of lines
            keyboardType: TextInputType.multiline,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Thoát'),
              onPressed: () {
                //    //    print( _textFieldController.text);
                setState(() {
                  _isLoading = false;
                });
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Xác nhận'),
              onPressed: () {
                // () async {
                //   await widget.buttonAction();
                // };
                //   //    print( widget.buttonAction);
                widget.buttonAction();
                //   //    print( widget.textEditingController.text);
                setState(() {
                  _isLoading = false;
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //   //    print( widget.buttonAction);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        boxShadow: shadowE1,
        color: context.appColor.colorWhite,
      ),
      child: SafeArea(
        minimum: EdgeInsets.symmetric(vertical: 8.h),
        child: ElevatedButton(
          onPressed: _isLoading || widget.buttonAction == null
              ? null
              : _handleButtonPress,
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(widget.buttonColor),
          ),
          child: _isLoading
              ? SizedBox(
                  height: 50,
                  width: 150, // Adjust the width as needed
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Đang xử lý',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: widget.textColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox(
                  height: 50,
                  // alignment: Alignment.center,
                  width: 150,
                  child: Center(
                    child: Text(
                      widget.buttonContent,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: widget.textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
          // color: Colors.blue,
        ),
      ),
    );
  }
}
