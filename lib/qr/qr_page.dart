import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:eco_app/helper/colors.dart';
import 'package:eco_app/helper/spaces.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({
    super.key,
  });
  // final List<CameraDescription> cameras;
  // final int? screenIndex;

  @override
  State<QrCodePage> createState() => _QrCodePagePageState();
}

class _QrCodePagePageState extends State<QrCodePage> {
  //variables and functions
  String? result;
  int counter = 0;
  bool isHasCreateQRCode = false;
  final ScreenshotController _screenshotController = ScreenshotController();
  // late CameraController cameraController;
  // QRViewController? controller;
  late bool checkWidget;
  bool isCheckScannerCount = false;

  Future<Image>? image;
  bool scanned = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  initState() {
    checkWidget = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlueGray02,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Mã QR của tôi'),
        backgroundColor: colorMain,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(flex: 10, child: _createQRCode(context)),
            // : Expanded(flex: 10, child: _buildQrView(context)),
          ],
        ),
      ),
    );
  }

  // Future<Uint8List> _capturePng() async {
  //   try {
  //     print('inside');
  //     RenderRepaintBoundary boundary =
  //         _globalKey.currentContext.findRenderObject();
  //     ui.Image image = await boundary.toImage(pixelRatio: 3.0);
  //     ByteData byteData =
  //         await image.toByteData(format: ui.ImageByteFormat.png);
  //     var pngBytes = byteData.buffer.asUint8List();
  //     var bs64 = base64Encode(pngBytes);
  //     print(pngBytes);
  //     print(bs64);
  //     setState(() {});
  //     return pngBytes;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future<ui.Image> _loadOverlayImage() async {
  //   final completer = Completer<ui.Image>();
  //   final byteData = await rootBundle.load('assets/images/logo_yakka.png');
  //   ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
  //   return completer.future;
  // }

  Widget _createQRCode(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400.w ||
            MediaQuery.of(context).size.height < 400.h)
        ? 200.0.r
        : 300.0.r;
    return Center(
      child: SizedBox(
        height: 350.r,
        width: 300.r,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Screenshot(
                    controller: _screenshotController,
                    child: Container(
                      color: Colors.white,
                      child: QrImageView(
                        data: 'ungnhothach',
                        errorCorrectionLevel: QrErrorCorrectLevel.H,
                        gapless: false,
                        version: QrVersions.auto,
                        size: scanArea,
                      ),
                    ),
                  ),
                ),
                spaceH30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        try {
                          await _screenshotController
                              .capture(delay: const Duration(microseconds: 500))
                              .then((Uint8List? image) async {
                            final directory =
                                (await getApplicationDocumentsDirectory()).path;
                            String path = '$directory/qr.png';
                            final imagePath =
                                await File(path).create(recursive: true);
                            await imagePath.writeAsBytes(image!);

                            /// Share Plugin
                          });
                          print('share...');
                        } catch (e) {
                          print('error... $e ');
                        }
                      },
                      // },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 16.r,
                              height: 16.r,
                              child: Image.asset(
                                'assets/icons/icon_share.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            spaceW8,
                            const Text(
                              'Chia sẻ QR',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(0, 104, 255, 1)),
                            )
                          ],
                        ),
                      ),
                    ),
                    spaceW36,
                    GestureDetector(
                      onTap: () async {
                        await _captureAndSaveQRCode();
                        print('path:$imagePath');
                        Fluttertoast.showToast(
                          msg: "Tải thành công",
                          gravity: ToastGravity.TOP,
                          toastLength: Toast.LENGTH_SHORT,
                          webPosition: 'top',
                        );
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 16.r,
                            height: 16.r,
                            child: Image.asset(
                              'assets/icons/icon_share.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          spaceW8,
                          const Text(
                            'Tải mã QR',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(0, 104, 255, 1)),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> get imagePath async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    return '$directory/qr.png';
  }

  Future<Image> _loadImage() async {
    return await imagePath.then((imagePath) => Image.asset(imagePath));
  }

  Future<void> _captureAndSaveQRCode() async {
    final imageDirectory = await imagePath;

    _screenshotController.captureAndSave(imageDirectory);
    setState(() {
      image = _loadImage();
    });
  }

  @override
  void dispose() {
    // controller?.dispose();
    super.dispose();
  }
}
