import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String message;
  final String titleConfirm;

  final VoidCallback? onConfirmPressed;

  const CustomAlertDialog({
    super.key,
    required this.message,
    this.onConfirmPressed,
    required this.titleConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        contentPadding: const EdgeInsets.only(top: 20),
        content: Padding(
          padding:
              const EdgeInsets.only(top: 32, right: 32, left: 32, bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 58, right: 58, top: 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 32,
                  // child: Image.asset(
                  //   Assets.icons.alert.path,
                  //   fit: BoxFit.fill,
                  // )
                ),
              ),
              spaceH32,
              Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Để sau',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: colorBlack),
                  ),
                ),
              ),
              TextButton(
                onPressed: onConfirmPressed ?? () {},
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: colorMain,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    titleConfirm,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: colorWhite),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
