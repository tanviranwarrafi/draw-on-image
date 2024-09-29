import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:tutorial/extensions/flutter_ext.dart';

class FileCompressor {
  Future<List<File>> compressMultipleImage(List<File> files) async {
    List<File> images = [];
    if (!files.haveList) return images;
    for (File item in files) {
      var image = await compressSingleImage(item);
      if (image != null) images.add(image);
    }
    return images;
  }

  Future<File?> compressSingleImage(File file) async {
    var filePath = file.absolute.path;

    /*if (filePath.endsWith('.heic') || filePath.endsWith('.HEIC') || filePath.endsWith('.heif') || filePath.endsWith('.HEIF')) {
      file = await _convertHeicToJpg(file);
      filePath = file.absolute.path;
    }*/

    var lastIndex = filePath.lastIndexOf(RegExp('.jp'));
    var splitPath = filePath.substring(0, lastIndex);
    var targetPath = '${splitPath}_target${filePath.substring(lastIndex)}';
    var compressedFile = await _compressImage(file, targetPath);
    // var compressedFile = await FlutterImageCompress.compressAndGetFile(file.absolute.path, targetPath, quality: 100);
    // print(await compressedFile!.length() / 1024);
    // if (compressedFile == null) return null;
    return compressedFile;
  }

  Future<File?> _compressImage(File file, String targetPath) async {
    File? imageFile;
    for (int quality = 0; quality <= 100; quality = quality + 10) {
      var image = await FlutterImageCompress.compressAndGetFile(file.absolute.path, targetPath, quality: 100 - quality);
      if (image != null && await image.length() <= 1024 * 1024) {
        imageFile = File(image.path);
        break;
      }
    }
    return imageFile;
  }

  /*Future<File> _convertHeicToJpg(File file) async {
    Uint8List bytes = await file.readAsBytes();
    img.Image? heicImage = img.decodeImage(bytes);
    if (heicImage == null) {
      throw Exception('Failed to decode HEIC image');
    }
    var jpgFilePath =
        file.path.replaceAll('.heic', '.jpg').replaceAll('.HEIC', '.jpg').replaceAll('.heif', '.jpg').replaceAll('.HEIF', '.jpg');
    File jpgFile = File(jpgFilePath);
    await jpgFile.writeAsBytes(img.encodeJpg(heicImage));
    return jpgFile;
  }*/
}
