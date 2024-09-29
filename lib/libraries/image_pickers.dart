import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickers {
  var _imagePicker = ImagePicker();

  Future<File?> imageFromCamera() async {
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    return File(image.path);
  }

  Future<File?> singleImageFromGallery() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    return File(image.path);
  }

  Future<List<File>> multiImageFromGallery() async {
    List<File> imageFiles = [];
    var images = await _imagePicker.pickMultiImage();
    if (images.isEmpty) return imageFiles;
    images.forEach((item) => imageFiles.add(File(item.path)));
    return imageFiles;
  }
}
