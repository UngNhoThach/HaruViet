import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;

class CameraService {
  CameraController? _cameraController;
  CameraController? get cameraController => _cameraController;

  // InputImageRotation? _cameraRotation;
  // InputImageRotation? get cameraRotation => _cameraRotation;

  // Future<void> initialize() async {
  //   if (_cameraController != null) return;
  //   CameraDescription description = await _getCameraDescription();
  //   await _setupCameraController(description: description);
  //   _cameraRotation = rotationIntToImageRotation(
  //     description.sensorOrientation,
  //   );
  // }

  Future<CameraDescription> _getCameraDescription() async {
    List<CameraDescription> cameras = await availableCameras();
    return cameras.firstWhere((CameraDescription camera) =>
        camera.lensDirection == CameraLensDirection.front);
  }

  Future _setupCameraController({
    required CameraDescription description,
  }) async {
    _cameraController = CameraController(
      description,
      ResolutionPreset.high,
      enableAudio: false,
    );
    await _cameraController?.initialize();
  }

  // InputImageRotation rotationIntToImageRotation(int rotation) {
  //   switch (rotation) {
  //     case 90:
  //       return InputImageRotation.rotation90deg;
  //     case 180:
  //       return InputImageRotation.rotation180deg;
  //     case 270:
  //       return InputImageRotation.rotation270deg;
  //     default:
  //       return InputImageRotation.rotation0deg;
  //   }
  // }

  Future<File?> takePicture() async {
    assert(_cameraController != null, 'Camera controller not initialized');
    await _cameraController?.stopImageStream();
    XFile? file = await _cameraController?.takePicture();

    final result = await ImageProcessor.cropSquare(file!.path);

    return result;
  }

  Size getImageSize() {
    assert(_cameraController != null, 'Camera controller not initialized');
    assert(
        _cameraController!.value.previewSize != null, 'Preview size is null');
    return Size(
      _cameraController!.value.previewSize!.height,
      _cameraController!.value.previewSize!.width,
    );
  }

  dispose() async {
    await _cameraController?.dispose();
    _cameraController = null;
  }
}

class ImageProcessor {
  static Future<File> cropSquare(String srcFilePath) async {
    var bytes = await File(srcFilePath).readAsBytes();
    img.Image src = img.decodeImage(bytes)!;

    var cropSize = min(src.width, src.height);
    // int offsetX = (src.width - min(src.width, src.height)) ~/ 2;
    // int offsetY = (src.height - min(src.width, src.height)) ~/ 2;

    img.Image destImage =
        img.copyCrop(src, x: 0, y: 0, height: cropSize, width: cropSize);

    // destImage = img.flipVertical(destImage);
    var jpg = img.encodeJpg(destImage);
    final result = await File(srcFilePath).writeAsBytes(jpg);

    return result;
  }
}
