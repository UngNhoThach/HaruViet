import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haruviet/helper/date_time.dart';

Future<void> showPopupLoading(
  BuildContext context, {
  String? text,
  bool isText = false,
  double? opacity,
  bool isWithOpacity = false,
  bool isPaddingBottom = false,
}) async {
  await showAppModalBottomSheetV3<void>(
    boxConstraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.9,
    ),
    context: context,
    enableDrag: false,
    isDismissible: false,
    child: Padding(
      padding: EdgeInsets.only(bottom: isPaddingBottom ? 100.h : 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 24.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: colorBlack.withOpacity(isWithOpacity ? opacity! : 0.5),
            ),
            child: Column(
              children: [
                const CircularProgressIndicator(
                  color: colorWhite,
                ),
                spaceH20,
                isText
                    ? space0
                    : Text(
                        text ?? 'Đang xử lý...',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorWhite,
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Future<T?> showAppModalBottomSheetV3<T>({
  required BuildContext context,
  required Widget child,
  bool isScrollControlled = true,
  bool isDismissible = true,
  bool enableDrag = true,
  BoxConstraints? boxConstraints,
}) {
  return showModalBottomSheet<T?>(
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    constraints: boxConstraints ??
        BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height -
              MediaQuery.of(context).viewPadding.top,
        ),
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: child,
      );
    },
  );
}

Future<T?> showAppModalBottomSheetV2<T>({
  required BuildContext context,
  required Widget child,
  bool isScrollControlled = true,
}) {
  return showModalBottomSheet<T?>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: isScrollControlled,
    builder: (c) => child,
  );
}

Future<T?> showAppModalBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  double? scaleHeight,
  bool isDismissible = true,
  bool enableDrag = true,
}) {
  return showModalBottomSheet<T>(
    isDismissible: isDismissible,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    enableDrag: enableDrag,
    context: context,
    builder: (modal) {
      return LayoutBuilder(
        builder: (modal, constraints) {
          final isScaleHeight = scaleHeight != null;
          Widget last = Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            alignment: Alignment.center,
            child: child,
          );
          if (isScaleHeight) {
            last = SizedBox(
              height: constraints.maxHeight *
                  ((constraints.maxHeight <= 736) ? 0.7 : scaleHeight),
              child: last,
            );
          } else {
            last = IntrinsicHeight(
              child: last,
            );
          }
          return AnimatedPadding(
            duration: const Duration(milliseconds: 100),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(modal).viewInsets.bottom,
            ),
            child: last,
          );
        },
      );
    },
  );
}

// Future<void> showImagesPicker(
//   BuildContext context, {
//   required ValueChanged<List<String>> imagesPicked,
//   bool isPickMultiImage = true,
// }) async {
//   return showCupertinoModalPopup<void>(
//     context: context,
//     builder: (c) => CupertinoActionSheet(
//       actions: [
//         CupertinoActionSheetAction(
//           child: const Text('Chọn từ thư viện'),
//           onPressed: () async {
//             c.justBack();
//             final cameraStatus = await Permission.photos.status;
//             if (cameraStatus.isPermanentlyDenied) {
//               Fluttertoast.showToast(
//                 msg:
//                     "Anh/chị chưa cấp quyền truy cập thư viện ảnh cho ứng dụng trong cài đặt",
//                 gravity: ToastGravity.TOP,
//                 toastLength: Toast.LENGTH_SHORT,
//                 webPosition: 'top',
//               );
//             }
//             final picker = ImagePicker();
//             // option pick image
//             if (isPickMultiImage) {
//               final files = await picker.pickMultiImage();
//               if (files.isNotEmpty) {
//                 final paths = files.map((e) => e.path).toList();
//                 imagesPicked(paths);
//               }
//             } else {
//               final file = await picker.pickImage(source: ImageSource.gallery);
//               if (file != null) {
//                 imagesPicked(
//                   [file.path],
//                 );
//               }
//             }
//           },
//         ),
//         CupertinoActionSheetAction(
//           child: const Text('Chụp ảnh'),
//           onPressed: () async {
//             c.justBack();
//             final cameraStatus = await [
//               Permission.camera,
//             ].request();
//             if (cameraStatus[Permission.camera] == PermissionStatus.granted) {
//               final picker = ImagePicker();
//               // Pick an image
//               final file = await picker.pickImage(
//                 source: ImageSource.camera,
//               );
//               if (file != null) {
//                 print('size: ${File(file.path).sizeOfImage()}');
//                 imagesPicked([file.path]);
//               }
//             } else {
//               Fluttertoast.showToast(
//                 msg:
//                     "Anh/chị chưa cấp quyền truy cập Camera cho ứng dụng trong phần cài đặt",
//                 gravity: ToastGravity.TOP,
//                 toastLength: Toast.LENGTH_SHORT,
//                 webPosition: 'top',
//               );
//             }
//           },
//         )
//       ],
//     ),
//   );
// }

Future<void> showDialogYearPicker({
  required BuildContext context,
  required int firstYear,
  required int lastYear,
  int? selectedYear,
  required void Function(int year) callback,
}) {
  if (firstYear > lastYear) {
    throw Exception('First year must be smaller than or equal to last year!');
  }

  context.hideKeyboard();
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: (modal) {
      final list = <int>[];
      for (var i = lastYear; i >= firstYear; i--) {
        list.add(i);
      }
      var itemSelected = selectedYear ?? list[0];
      return LayoutBuilder(
        builder: (modal, constraints) {
          return AnimatedPadding(
            duration: const Duration(milliseconds: 100),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(modal).viewInsets.bottom,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: context.appColor.colorWhite,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.all(16),
              height: constraints.maxHeight * 0.3,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Chọn năm',
                        style: textTheme.titleLarge,
                      ),
                      InkWell(
                        child: const Text(
                          'Xong',
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          callback(itemSelected);
                        },
                      )
                    ],
                  ),
                  Expanded(
                    child: ListWheelScrollView(
                      itemExtent: 42,
                      useMagnifier: true,
                      magnification: 1.5,
                      children: list.map((e) => Text(e.toString())).toList(),
                      onSelectedItemChanged: (value) {
                        itemSelected = list[value];
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

// Future<String> changeFileNameOnly(String filePath) async {
//   final file = File(filePath);
//   if (file.existsSync()) {
//     final uuid = const Uuid().v1();
//     final fileName = '$uuid.jpg';
//     final content = await file.readAsBytes();
//     final localPath = await _getTemporaryDirectory();
//     final fileLocation = File('$localPath/$fileName');
//     final newFile = await fileLocation.writeAsBytes(content);
//     return newFile.path;
//   }
//   throw Exception(['Could not rename file']);
// }

// Future<String> _getTemporaryDirectory() async {
//   final tempDir = await getTemporaryDirectory();
//   return tempDir.path;
// }

Future<void> showDialogDatePicker({
  required BuildContext context,
  DateTime? min,
  DateTime? max,
  DateTime? selected,
  String? title,
  required void Function(DateTime datetime) callback,
}) async {
  context.hideKeyboard();
  final minDate = min?.toDay;
  final now = DateTime.now();
  var date = selected != null
      ? DateTime(selected.year, selected.month, selected.day)
      : (min != null
          ? (minDate ?? DateTime(now.year, now.month, now.day))
          : DateTime(now.year, now.month, now.day));
  final maxDate = max != null ? DateTime(max.year, max.month, max.day) : null;
  await showCupertinoModalPopup<void>(
    context: context,
    builder: (c) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: 320,
          child: CupertinoApp(
            supportedLocales: const [Locale('vi', 'VN')],
            debugShowCheckedModeBanner: false,
            // đang thiếu
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(c);
                        },
                        child: Text(
                          'Hủy',
                          style: TextStyle(
                            color: context.appColor.colorRed,
                          ),
                        ),
                      ),
                      Text(
                        'Chọn thời gian',
                        style: textTheme.bodyMedium?.copyWith(
                            color: context
                                .appColorScheme.colorExtendedTextBodyMedium),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(c).pop();
                          callback(date);
                        },
                        child: Text(
                          'Xong',
                          style: TextStyle(
                            color: context.appColor.colorBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CupertinoTheme(
                    data: const CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                        dateTimePickerTextStyle:
                            TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    child: CupertinoDatePicker(
                      initialDateTime: date,
                      minimumDate: minDate,
                      maximumDate: maxDate,
                      mode: CupertinoDatePickerMode.date,
                      use24hFormat: true,
                      // This is called when the user changes the date.
                      onDateTimeChanged: (DateTime newDate) {
                        date = newDate;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

int _convertMinute(int hour, int minute) {
  return ((minute / 60 - hour) * 60).toInt();
}
