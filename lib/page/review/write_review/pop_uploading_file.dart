import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haruviet/component/popup/popup.dart';
import 'package:haruviet/component/title_btottom/title_bottom_sheet_wrapper.dart';
import 'package:haruviet/gen/assets.gen.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/theme/typography.dart';

class PopupChangeTypeUploadFile extends StatefulWidget {
  const PopupChangeTypeUploadFile._(this.onTap);

  final void Function(int) onTap;

  static Future<void> show(
    BuildContext context, {
    required void Function(int) onTap,
  }) {
    return showAppModalBottomSheetV3<void>(
      context: context,
      child: PopupChangeTypeUploadFile._(onTap),
    );
  }

  @override
  State<PopupChangeTypeUploadFile> createState() =>
      _PopupChangeTypeUploadFileState();
}

class _PopupChangeTypeUploadFileState extends State<PopupChangeTypeUploadFile> {
  @override
  Widget build(BuildContext context) {
    return TitleBottomSheetAutoHeightWrapper(
      title: 'Tải lên file đính kèm',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _item(
              context,
              title: 'Tải hình ảnh',
              icon: Assets.icons.delivery.image(
                height: 24.r,
                width: 24.r,
              ),
              onTap: () {
                widget.onTap(1);
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 4.h,
              ),
              child: const Divider(thickness: 1),
            ),
            _item(
              context,
              title: 'Tải File',
              icon: Assets.icons.delivery.image(
                height: 24.r,
                width: 24.r,
                color: const Color(0xFF6AA7FF),
              ),
              onTap: () {
                widget.onTap(2);
              },
            ),
            spaceH20,
          ],
        ),
      ),
    );
  }

  Widget _item(
    BuildContext context, {
    required String title,
    required Widget icon,
    required void Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 4.h,
        ),
        child: Row(
          children: [
            icon,
            spaceW8,
            Expanded(
              child: Text(
                title,
                style: textTheme.bodyMedium?.copyWith(
                  color: context.appColorScheme.colorExtendedTextBodyMedium,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            spaceW8,
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: colorGray03,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
