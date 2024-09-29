import 'dart:async';
import 'dart:io' as io;
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tutorial/di.dart';
import 'package:tutorial/extensions/flutter_ext.dart';
import 'package:tutorial/models/drawing_point.dart';

class ImageService {
  Future<Uint8List?> fileToUnit8List(io.File file) async => (await file.readAsBytes()).buffer.asUint8List();

  Future<Uint8List?> UrlToUnit8List(String url) async => (await NetworkAssetBundle(Uri.parse(url)).load(url)).buffer.asUint8List();

  Future<Uint8List> getBytesFromAsset({required String path}) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: 50, targetHeight: 50);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  Future<ui.Image> fileToUiImage(File image) async {
    var imageBytes = await image.readAsBytes();
    var uiImage = await decodeImageFromList(imageBytes);
    return uiImage;
  }

  Future<File?> renderImageWithDrawPoints(File image, List<DrawingPoint> drawingPoints) async {
    ui.Image uiImage = await sl<ImageService>().fileToUiImage(image);
    try {
      var recorder = ui.PictureRecorder(); // Create a new canvas with the original image's size
      var canvas = Canvas(recorder, Rect.fromLTWH(0, 0, uiImage.width.toDouble(), uiImage.height.toDouble()));
      canvas.drawImage(uiImage, Offset.zero, Paint()); // Draw the original image

      var paint = Paint()..strokeCap = StrokeCap.round; // Draw the drawing points on top of the image
      for (var point in drawingPoints) {
        paint.color = point.color;
        paint.strokeWidth = point.width;
        for (int i = 0; i < point.offsets.length - 1; i++) {
          canvas.drawLine(point.offsets[i], point.offsets[i + 1], paint);
        }
      }

      var picture = recorder.endRecording(); // Convert the canvas to an image
      var updatedImage = await picture.toImage(uiImage.width, uiImage.height);

      var byteData = await updatedImage.toByteData(format: ui.ImageByteFormat.png); // Convert the image to PNG
      var pngBytes = byteData!.buffer.asUint8List();

      var directory = await getApplicationDocumentsDirectory(); // Save the image to the file system
      var filePath = '${directory.path}/image_${currentDate.millisecondsSinceEpoch}.png';
      var imageFile = File(filePath);
      await imageFile.writeAsBytes(pngBytes);
      return imageFile;
    } catch (e) {
      if (kDebugMode) print('Error saving image: $e');
      return null;
    }
  }
}
