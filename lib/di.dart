import 'package:get_it/get_it.dart';
import 'package:tutorial/libraries/file_compressor.dart';
import 'package:tutorial/libraries/image_croppers.dart';
import 'package:tutorial/libraries/image_pickers.dart';
import 'package:tutorial/libraries/toasts_popups.dart';
import 'package:tutorial/services/image_service.dart';
import 'package:tutorial/themes/transitions.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Libraries
  sl.registerLazySingleton<FileCompressor>(FileCompressor.new);
  // sl.registerLazySingleton<Formatters>(Formatters.new);
  sl.registerLazySingleton<ImageCroppers>(ImageCroppers.new);
  sl.registerLazySingleton<ImagePickers>(ImagePickers.new);
  sl.registerLazySingleton<ToastPopup>(ToastPopup.new);
  sl.registerLazySingleton<ImageService>(ImageService.new);
  sl.registerLazySingleton<Transitions>(Transitions.new);
}
