import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haruviet/component/button/bottom_bar_button.dart';
import 'package:haruviet/component/button/solid_button.dart';
import 'package:haruviet/component/loading/loading.dart';
import 'package:haruviet/component/shimer/image_product_shimer.dart';
import 'package:haruviet/component/snackbar/snackbar_bottom.dart';
import 'package:haruviet/data/data_local/setting_app_bloc.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/file_extensisons.dart';
import 'package:haruviet/helper/file_uploading/chunk_upload_service.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/review/write_review/widgets/write_review_params.dart';
import 'package:haruviet/page/review/write_review/write_review_bloc.dart';
import 'package:haruviet/page/review/write_review/write_review_state.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class WriteReviewPage extends StatefulWidget {
  final WriteReviewParams? params;
  const WriteReviewPage({super.key, this.params});

  @override
  State<WriteReviewPage> createState() => _WriteReviewPageState();
}

class _WriteReviewPageState extends State<WriteReviewPage> {
  int? replyId;
  late WriteReviewBloc bloc;
  late String domain;
  final _formKey = GlobalKey<FormState>();
  late final UploadFile uploader;

  @override
  initState() {
    domain = context.read<SettingAppBloc>().state.xUrl ?? '';
    bloc = WriteReviewBloc(params: widget.params)..getData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  IconData? _selectedIcon;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<WriteReviewBloc, WriteReviewState>(
        listenWhen: (previous, current) {
          return previous.isSubmitted != current.isSubmitted &&
              current.isSubmitted == true;
        },
        listener: (context, state) {
          if (state.isSuccess == true) {
            context.justBack();
            CustomSnackBar.showTop(context, state.messsage ?? '', null);
          } else {
            CustomSnackBar.showTop(context, state.messsage ?? '', null);
          }
        },
        child: BlocBuilder<WriteReviewBloc, WriteReviewState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text('Viết đánh giá'),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                body: state.isLoading
                    ? const LoadingLogo()
                    : Stack(
                        children: [
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                spaceH16,
                                SingleChildScrollView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          spaceW12,
                                          Expanded(
                                            flex: 4,
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(0),
                                                bottomRight: Radius.circular(0),
                                                topLeft: Radius.circular(8),
                                                topRight: Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                fadeOutDuration:
                                                    const Duration(seconds: 3),
                                                imageUrl:
                                                    '$domain${state.dataProduct?.image ?? ''}',
                                                width: 60.w,
                                                // placeholder: (context, url) =>
                                                //     ImageProductShimer(
                                                //   width: 60.w,
                                                //   height: 60.h,
                                                // ), // Use the custom shimmer component
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                              // Image.network(
                                              //   '$domain${state.dataProduct?.image ?? ''}',
                                              //   height: MediaQuery.of(context)
                                              //           .size
                                              //           .height *
                                              //       0.16,
                                              //   fit: BoxFit.contain,
                                              // ),
                                            ),
                                          ),
                                          spaceW12,
                                          Expanded(
                                            flex: 7,
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  top: 16.h,
                                                  left: 4.w,
                                                  right: 4.w),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        state.dataProduct
                                                                    ?.promotionPrice ==
                                                                null
                                                            ? '${state.dataProduct?.price?.priceStr}'
                                                            : '${state.dataProduct?.promotionPrice?.pricePromotion?.priceStr}',
                                                        style: textTheme
                                                            .bodyLarge
                                                            ?.copyWith(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      state.dataProduct
                                                                  ?.promotionPrice !=
                                                              null
                                                          ? Text(
                                                              '${state.dataProduct?.price?.priceStr}',
                                                              style: textTheme
                                                                  .bodyMedium
                                                                  ?.copyWith(
                                                                color:
                                                                    colorItemCover,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                              ),
                                                            )
                                                          : space0,
                                                    ],
                                                  ),
                                                  spaceH6,
                                                  Text(
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    state
                                                            .dataProduct
                                                            ?.descriptions
                                                            ?.name ??
                                                        '',
                                                    style: textTheme.titleSmall
                                                        ?.copyWith(
                                                      color: colorBlack,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  spaceH6,
                                                  Text(
                                                    state.dataProduct?.brand
                                                            ?.name ??
                                                        '',
                                                    style: textTheme.titleSmall
                                                        ?.copyWith(
                                                      color: colorGray03,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  spaceH6,
                                                ],
                                              ),
                                            ),
                                          ),
                                          spaceW16,
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                spaceH4,

                                const Divider(
                                  color: colorMain,
                                  thickness: 2,
                                ),
                                spaceH12,

                                Text(
                                  getRatingText(state.rating),
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: context.appColorScheme
                                        .colorExtendedTextBodyMedium,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                // make ratting
                                Column(
                                  children: [
                                    spaceH12,
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: RatingBar.builder(
                                        initialRating: state.rating,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        itemSize: 40,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        itemBuilder: (context, _) => Icon(
                                          _selectedIcon ?? Icons.star,
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                        ),
                                        onRatingUpdate: (rating) {
                                          bloc.onChangeRating(rating: rating);
                                          // _rating = rating;
                                          // setState(() {});
                                        },
                                      ),
                                    ),
                                    spaceH16,
                                    // const Divider(
                                    //   color: colorGray03,
                                    //   thickness: 2,
                                    //   height: 2,
                                    // ),
                                    Container(
                                      color: colorGray02,
                                      padding: EdgeInsets.all(16.r),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              IconButton(
                                                  onPressed:
                                                      // () {
                                                      //   _getFromGallery(context);
                                                      // },
                                                      _onTapUploadFile,

                                                  // () {
                                                  // Navigator.of(context)
                                                  //     .push(MaterialPageRoute(
                                                  //   builder: (context) {
                                                  //     return const CameraPage();
                                                  //   },
                                                  // ));
                                                  //    },
                                                  icon: const Icon(
                                                    Icons.camera_alt_outlined,
                                                    size: 40,
                                                  )),
                                              spaceH16,
                                              Text(
                                                'Thêm hình ảnh thực tế (không bắt buộc)',
                                                style: textTheme.bodyMedium
                                                    ?.copyWith(
                                                  color: colorGray04,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              spaceH8,
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    // const Divider(
                                    //   color: colorGray03,
                                    //   thickness: 2,
                                    //   height: 2,
                                    // ),
                                    TextFormField(
                                      minLines: 4, // Set this
                                      maxLines: 100, // and this
                                      key: _formKey,
                                      enabled: true,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(16),
                                          hintText: "Để lại đánh giá chi tiết"),
                                      onChanged: (value) {
                                        bloc.onChangeComment(comment: value);
                                      },
                                      onFieldSubmitted: (value) {
                                        bloc.onChangeComment(comment: value);
                                      },
                                    ),
                                  ],
                                ),
                                spaceH72,
                              ],
                            ),
                          ),
                        ],
                      ),
                bottomNavigationBar: BottomBarButton(
                  button1: AppSolidButton.medium(
                    context: context,
                    color: Theme.of(context).primaryColor,
                    'Gửi đánh giá',
                    onPressed: bloc.state.isValid
                        ? () {
                            bloc.onSubmitReview();
                          }
                        : null,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onTapUploadFile() {
    //  showAlertDialog(context);
    showImagesPicker(
      context,
      imagesPicked: (uris) async {
        if (uris.isNotEmpty) {
          final files = uris
              .map((e) => PlatformFile(
                    path: e,
                    name: Path.basename(e),
                    size: File(e).lengthSync(),
                  ))
              .toList();
          await uploader.addFile(files);
        }
      },
    );

    // select method

    // PopupChangeTypeUploadFile.show(context, onTap: (type) async {
    //   context.justBack();
    //   if (type == 1) {
    //     showImagesPicker(
    //       context,
    //       imagesPicked: (uris) {
    //         if (uris.isNotEmpty) {
    //           final files = uris
    //               .map((e) => PlatformFile(
    //                     path: e,
    //                     name: Path.basename(e),
    //                     size: File(e).lengthSync(),
    //                   ))
    //               .toList();
    //           uploader.addFile(files);
    //         }
    //       },
    //     );
    //   } else {
    //     final result = await FilePicker.platform
    //         .pickFiles(withReadStream: true, allowMultiple: true);
    //     if (result != null) {
    //       await uploader.addFile(result.files);
    //     }
    //   }
    // });
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
  Future<void> showImagesPicker(
    BuildContext context, {
    required ValueChanged<List<String>> imagesPicked,
    bool isPickMultiImage = true,
  }) async {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (c) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Chọn từ thư viện'),
            onPressed: () async {
              c.justBack();
              final cameraStatus = await Permission.photos.status;
              if (cameraStatus.isPermanentlyDenied) {
                Fluttertoast.showToast(
                  msg:
                      "Anh/chị chưa cấp quyền truy cập thư viện ảnh cho ứng dụng trong cài đặt",
                  gravity: ToastGravity.TOP,
                  toastLength: Toast.LENGTH_SHORT,
                  webPosition: 'top',
                );
              }
              final picker = ImagePicker();
              // option pick image
              if (isPickMultiImage) {
                final files = await picker.pickMultiImage();
                if (files.isNotEmpty) {
                  final paths = files.map((e) => e.path).toList();
                  imagesPicked(paths);
                }
              } else {
                final file =
                    await picker.pickImage(source: ImageSource.gallery);
                if (file != null) {
                  imagesPicked(
                    [file.path],
                  );
                }
              }
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Chụp ảnh'),
            onPressed: () async {
              c.justBack();
              final cameraStatus = await [
                Permission.camera,
              ].request();
              if (cameraStatus[Permission.camera] == PermissionStatus.granted) {
                final picker = ImagePicker();
                // Pick an image
                final file = await picker.pickImage(
                  source: ImageSource.camera,
                );
                if (file != null) {
                  print('size: ${File(file.path).sizeOfImage()}');
                  imagesPicked([file.path]);
                }
              } else {
                Fluttertoast.showToast(
                  msg:
                      "Anh/chị chưa cấp quyền truy cập Camera cho ứng dụng trong phần cài đặt",
                  gravity: ToastGravity.TOP,
                  toastLength: Toast.LENGTH_SHORT,
                  webPosition: 'top',
                );
              }
            },
          )
          // CupertinoActionSheetAction(
          //   child: const Text('Chụp ảnh'),
          //   onPressed: () async {
          //     c.justBack();
          //     final cameraStatus = await Permission.camera.status;
          //     final locaotion = await Permission.location.isDenied;
          //     // The OS restricts access, for example, because of parental control.

          //     if (!cameraStatus.isDenied && !locaotion) {
          //       final picker = ImagePicker();
          //       // Pick an image
          //       final file = await picker.pickImage(
          //         source: ImageSource.camera,
          //       );
          //       if (file != null) {
          //         print('size: ${File(file.path).sizeOfImage()}');
          //         imagesPicked([file.path]);
          //       }
          //     } else {
          //       Fluttertoast.showToast(
          //         msg:
          //             "Anh/chị chưa cấp quyền truy cập Camera cho ứng dụng trong phần cài đặt",
          //         gravity: ToastGravity.TOP,
          //         toastLength: Toast.LENGTH_SHORT,
          //         webPosition: 'top',
          //       );
          //     }
          //   },
          // )
        ],
      ),
    );
  }

  showAlertDialog(context) => showCupertinoDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Permission Denied'),
          content: const Text('Allow access to gallery and photos'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                await openAppSettings(); // Đợi `openAppSettings` hoàn tất
                Navigator.of(context).pop(); // Sau đó đóng dialog
              },
              child: const Text('Settings'),
            ),
          ],
        ),
      );

// rating case
  String getRatingText(double rating) {
    switch (rating.toInt()) {
      case 0:
        return 'Chạm vào để đánh giá';
      case 1:
        return 'Rất tệ';
      case 2:
        return 'Tệ';
      case 3:
        return 'Bình thường';
      case 4:
        return 'Tốt';
      default:
        return 'Rất tốt';
    }
  }
}
