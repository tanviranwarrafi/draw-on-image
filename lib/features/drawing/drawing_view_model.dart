import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:tutorial/di.dart';
import 'package:tutorial/features/drawing/dialogs/no_camera_dialog.dart';
import 'package:tutorial/features/drawing/dialogs/test_image_dialog.dart';
import 'package:tutorial/libraries/flush_popup.dart';
import 'package:tutorial/libraries/image_croppers.dart';
import 'package:tutorial/libraries/image_pickers.dart';
import 'package:tutorial/models/drawing_point.dart';
import 'package:tutorial/services/image_service.dart';

class DrawingViewModel with ChangeNotifier {
  var loader = true;
  var isPencil = false;
  var isFlashOn = false;
  var drawingPoints = <DrawingPoint>[];
  var cameras = <CameraDescription>[];
  CameraController? cameraController;
  File? image;

  Future<void> initViewModel() async {
    disposeViewModel();
    loader = true;
    notifyListeners();
    await _initializeCamera();
    loader = false;
    notifyListeners();
  }

  void disposeViewModel() {
    loader = true;
    isPencil = false;
    isFlashOn = false;
    drawingPoints.clear();
    image = null;
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    if (cameras.isEmpty) return noCameraDialog();
    var backCameraIndex = cameras.indexWhere((item) => item.lensDirection == CameraLensDirection.back);
    if (backCameraIndex < 0) return noCameraDialog();
    cameraController = CameraController(cameras[backCameraIndex], ResolutionPreset.high);
    await cameraController?.initialize();
    await Future.delayed(const Duration(milliseconds: 200));
    notifyListeners();
  }

  Future<void> capturePhoto() async {
    if (cameraController == null || !cameraController!.value.isInitialized) return;
    var file = await cameraController!.takePicture();
    image = File(file.path);
    notifyListeners();
  }

  Future<void> imageFromGallery() async {
    var file = await sl<ImagePickers>().singleImageFromGallery();
    if (file != null) image = file;
    notifyListeners();
  }

  Future<void> onCropImage() async {
    if (drawingPoints.isNotEmpty) return sl<FlushPopup>().onWarning(message: 'Please remove your sketch then crop');
    image = await sl<ImageCroppers>().cropImage(image: image!);
    notifyListeners();
  }

  void onCancelImage() {
    image = null;
    isPencil = false;
    notifyListeners();
  }

  Future<void> flashActions() async {
    try {
      var flashMode = isFlashOn ? FlashMode.off : FlashMode.torch;
      await cameraController!.setFlashMode(flashMode);
      isFlashOn = !isFlashOn;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) print('Flashlight Error: $e');
    }
  }

  void onDrawing(List<DrawingPoint> points) {
    drawingPoints = points;
    notifyListeners();
  }

  Future<void> onConfirm() async {
    if (image == null) return;
    var file = drawingPoints.isEmpty ? image! : await sl<ImageService>().renderImageWithDrawPoints(image!, drawingPoints);
    if (file != null) await testImageDialog(file: file);
  }
}
