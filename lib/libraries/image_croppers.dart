import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:tutorial/themes/colors.dart';

const _aspectRatio = CropAspectRatio(ratioX: 1000, ratioY: 1000);

/*const _androidRatio = [
  CropAspectRatioPreset.square,
  CropAspectRatioPreset.ratio3x2,
  CropAspectRatioPreset.original,
  CropAspectRatioPreset.ratio4x3,
  CropAspectRatioPreset.ratio16x9,
];*/

/*const _iosRatio = [
  CropAspectRatioPreset.original,
  CropAspectRatioPreset.square,
  CropAspectRatioPreset.ratio3x2,
  CropAspectRatioPreset.ratio4x3,
  CropAspectRatioPreset.ratio5x3,
  CropAspectRatioPreset.ratio5x4,
  CropAspectRatioPreset.ratio7x5,
  CropAspectRatioPreset.ratio16x9,
];*/

var _androidUiSettings = AndroidUiSettings(
  toolbarColor: primary,
  lockAspectRatio: false,
  statusBarColor: primary,
  toolbarWidgetColor: white,
  toolbarTitle: 'Edit Photo',
  initAspectRatio: CropAspectRatioPreset.original,
);

var _iosUiSettings = IOSUiSettings(title: 'Edit Photo');

class ImageCroppers {
  ImageCropper imageCropper = ImageCropper();

  Future<File?> cropImage({required File image}) async {
    var cropped = await imageCropper.cropImage(
      maxHeight: 625,
      maxWidth: 1000,
      compressQuality: 10,
      sourcePath: image.path,
      aspectRatio: _aspectRatio,
      compressFormat: ImageCompressFormat.png,
      uiSettings: [_androidUiSettings, _iosUiSettings],
      // aspectRatioPresets: Platform.isAndroid ? _androidRatio : _iosRatio,
    );
    return cropped == null ? null : File(cropped.path);
  }
}
