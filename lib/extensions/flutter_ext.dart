import 'package:flutter/material.dart';
import 'package:tutorial/utils/keys.dart';

DateTime get currentDate => DateTime.now();
BuildContext get _context => navigatorKey.currentState!.context;

extension ListExtension on List<dynamic>? {
  bool get haveList => this != null && this!.length > 0;
}

extension FlutterExtensions on void {
  void backToPrevious() => Navigator.of(navigatorKey.currentState!.context).pop();
  void minimizeKeyboard() => FocusScope.of(navigatorKey.currentState!.context).unfocus();
}

extension PushRoute on Widget {
  Future<dynamic> push() => Navigator.push(_context, MaterialPageRoute(builder: (context) => this));

  Future<void> pushReplacement() => Navigator.pushReplacement(_context, MaterialPageRoute(builder: (context) => this));

  Future<dynamic> pushAndRemoveUntil() => Navigator.pushAndRemoveUntil(
        _context,
        MaterialPageRoute(builder: (context) => this),
        (route) => false,
      );
}
