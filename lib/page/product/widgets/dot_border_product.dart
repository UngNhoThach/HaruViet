import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/theme/typography.dart';

class DotBorderProduct extends StatelessWidget {
  const DotBorderProduct({super.key, required this.value});
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6.h),
      child: DottedBorder(
        radius: const Radius.circular(20),
        strokeCap: StrokeCap.round,
        color: Theme.of(context).primaryColorLight,
        dashPattern: const [2, 4],
        strokeWidth: 1.6,
        child: Container(
          color: colorMainCover.withOpacity(0.2),
          padding: const EdgeInsets.all(2),
          child: Text(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              value,
              style: textTheme.bodySmall),
        ),
      ),
    );
  }
}
