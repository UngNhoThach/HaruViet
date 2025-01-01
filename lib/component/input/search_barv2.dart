import 'dart:async';

import 'package:haruviet/component/input/text_filed.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSearchBarV2 extends StatefulWidget {
  const AppSearchBarV2({
    super.key,
    this.readOnly = false,
    this.hintText = '',
    required this.onTap,
  });

  final bool readOnly;
  final String? hintText;
  final void Function() onTap;

  @override
  State<AppSearchBarV2> createState() => _AppSearchBarV2State();
}

class _AppSearchBarV2State extends State<AppSearchBarV2> {
  late Timer _debounce;

  @override
  void initState() {
    super.initState();
    _debounce = Timer(Duration.zero, () {});
  }

  @override
  void dispose() {
    _debounce.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ColoredBox(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                height: 32.h,
                child: Center(
                  child: AppTextFormField(
                    readOnly: true,
                    showCursor: false, // Disable the cursor
                    autofocus: false,
                    enableInteractiveSelection: false,
                    onTap: widget.onTap,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      fillColor: colorWhite,
                      focusColor: colorWhite,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: colorWhite,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                      hintText: widget.hintText,
                      hintStyle: textTheme.bodyMedium?.copyWith(
                        color: context
                            .appColorScheme.colorExtendedTextBodyMedium
                            .withOpacity(0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: colorWhite,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
