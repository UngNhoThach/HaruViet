import 'package:eco_app/component/button/solid_button.dart';
import 'package:eco_app/component/popup/popup.dart';
import 'package:eco_app/component/title_btottom/title_bottom_sheet_wrapper.dart';
import 'package:eco_app/helper/colors.dart';
import 'package:eco_app/helper/context.dart';
import 'package:eco_app/helper/spaces.dart';
import 'package:eco_app/page/product/detail/widgets/widgets/color_option.dart';
import 'package:eco_app/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopupCreateTerminationResignation extends StatefulWidget {
  const PopupCreateTerminationResignation._({
    required this.onReload,
    required this.colorSelected,
  });
  final String colorSelected;
  final VoidCallback onReload;
  static Future<void> show(
    BuildContext context, {
    required String colorSelected,
    required VoidCallback onReload,
  }) {
    return showAppModalBottomSheetV3<void>(
      context: context,
      child: PopupCreateTerminationResignation._(
        onReload: onReload,
        colorSelected: colorSelected,
      ),
    );
  }

  @override
  State<PopupCreateTerminationResignation> createState() =>
      _PopupChangePersonalInformationState();
}

class _PopupChangePersonalInformationState
    extends State<PopupCreateTerminationResignation> {
  int indexSelected = 0;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  void initState() {
    super.initState();
    indexSelected = ColorWorkPlan.values.indexWhere(
        (element) => element == ColorWorkPlan.from(widget.colorSelected));
  }

  @override
  Widget build(BuildContext context) {
    return TitleBottomSheetAutoHeightWrapper(
      title: 'Dung tích 200l',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    height: 30.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: colorMain), // Đặt màu đen cho viền
                    ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Căn giữa theo chiều ngang
                      children: [
                        spaceW16,
                        const Text('400l',
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    height: 30.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: colorGray02), // Đặt màu đen cho viền
                    ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Căn giữa theo chiều ngang
                      children: [
                        spaceW16,
                        const Text('500l',
                            style: TextStyle(
                                color:
                                    Colors.black)), // Đặt màu đen cho văn bản
                      ],
                    ),
                  ),
                ),
              ],
            ),
            spaceH10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Màu sắc',
                  style: textTheme.titleMedium,
                  // style: textTheme.bodySmall?.copyWith(
                  //   color: colorGray04,
                  //   fontWeight: FontWeight.w500,
                  // ),
                ),
              ],
            ),
            spaceH10,
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 60,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: ColorWorkPlan.values.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      crossAxisCount: 6,
                    ),
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            indexSelected = i;
                          });
                        },
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            if (i == indexSelected)
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 2,
                                    color: ColorWorkPlan.values[i].data,
                                  ),
                                ),
                              ),
                            Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorWorkPlan.values[i].data,
                              ),
                            ),
                            if (i == indexSelected)
                              const Icon(
                                Icons.check_rounded,
                                color: colorWhite,
                                size: 32,
                              )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                spaceH10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Số lượng:',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorGray05,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              _decrementCounter();
                            },
                            child: const Icon(
                              Icons.remove,
                              color: colorGray05,
                            )),
                        spaceW16,
                        SizedBox(
                          width: 60,
                          height: 30,
                          child: TextField(
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (newValue) {
                              if (int.tryParse(newValue) != null) {
                                setState(() {
                                  _counter = int.parse(newValue);
                                });
                              }
                            },
                            controller:
                                TextEditingController(text: '$_counter'),
                          ),
                        ),
                        spaceW16,
                        GestureDetector(
                          onTap: () {
                            _incrementCounter();
                          },
                          child: const Icon(
                            Icons.add,
                            color: colorGray05,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            spaceH16,
            AppSolidButton.medium(
              onPressed: () {},
              'Lưu',
            ),
            spaceH20,
            spaceH20,
          ],
        ),
      ),
    );
  }

  Widget _item(
    BuildContext context, {
    required String title,
    String? router,
    Object? arguments,
  }) {
    return InkWell(
      onTap: () {
        if (router != null) {
          try {
            // context.justBack();
            // routeService.pushNamed(router, arguments: arguments);
          } catch (e, s) {}
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 4.h,
        ),
        child: Row(
          children: [
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
              color: colorGray04,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
