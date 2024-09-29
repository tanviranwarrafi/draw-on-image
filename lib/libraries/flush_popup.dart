import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:tutorial/themes/colors.dart';
import 'package:tutorial/utils/assets.dart';
import 'package:tutorial/utils/keys.dart';
import 'package:tutorial/widgets/library/svg_image.dart';

class FlushPopup {
  // String get _name => /*sl<StorageService>().user*/ '';

  void onSuccess({required String message}) {
    var dataModel = _FLushModel(title: 'Congratulations!!', message: message);
    _showFlushbar(model: dataModel);
  }

  void onInfo({required String message}) {
    var dataModel = _FLushModel(title: 'Message', message: message, background: info);
    _showFlushbar(model: dataModel);
  }

  void onWarning({required String message}) {
    var dataModel = _FLushModel(title: 'Attention!', message: message, background: warning, icon: Assets.svg.info);
    _showFlushbar(model: dataModel);
  }

  void onError({required String message}) {
    var dataModel = _FLushModel(title: 'Error!', message: message, background: error);
    _showFlushbar(model: dataModel);
  }

  void _showFlushbar({required _FLushModel model}) {
    var radius = BorderRadius.circular(10);
    var direction = FlushbarDismissDirection.HORIZONTAL;
    var padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 15);
    var margin = EdgeInsets.only(left: 20, right: 20, top: Platform.isAndroid ? 20 : 0);
    Flushbar(
      titleSize: 16,
      messageSize: 14,
      message: model.message,
      titleColor: white,
      messageColor: white,
      title: model.title,
      borderRadius: radius,
      dismissDirection: direction,
      padding: padding,
      margin: margin,
      icon: model.icon.isEmpty ? null : SvgImage(image: Assets.svg.info, height: 28, color: white),
      backgroundColor: model.background,
      duration: const Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(navigatorKey.currentContext!);
  }
}

class _FLushModel {
  String title;
  String message;
  Color background;
  String icon;

  _FLushModel({this.title = '', this.message = '', this.background = success, this.icon = ''});
}
