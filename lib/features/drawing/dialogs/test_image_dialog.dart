import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tutorial/components/buttons/elevate_button.dart';
import 'package:tutorial/di.dart';
import 'package:tutorial/extensions/flutter_ext.dart';
import 'package:tutorial/themes/colors.dart';
import 'package:tutorial/themes/transitions.dart';
import 'package:tutorial/utils/dimensions.dart';
import 'package:tutorial/utils/keys.dart';
import 'package:tutorial/widgets/core/pop_scope_navigator.dart';

Future<void> testImageDialog({required File file}) async {
  var context = navigatorKey.currentState!.context;
  await showGeneralDialog(
    context: context,
    barrierLabel: 'No Camera Dialog',
    transitionDuration: DIALOG_DURATION,
    transitionBuilder: sl<Transitions>().topToBottom,
    pageBuilder: (buildContext, anim1, anim2) => PopScopeNavigator(canPop: false, child: Align(child: _DialogView(file))),
  );
}

class _DialogView extends StatelessWidget {
  final File file;
  _DialogView(this.file);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.dialog_width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: white, borderRadius: DIALOG_RADIUS),
      child: Material(color: transparent, child: _screenView(context), shape: DIALOG_SHAPE),
    );
  }

  Widget _screenView(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(borderRadius: BorderRadius.circular(12), child: FittedBox(child: Image.file(file))),
        const SizedBox(height: 24),
        ElevateButton(label: 'Go Back', width: double.infinity, onTap: _onBack),
      ],
    );
  }

  void _onBack() {
    backToPrevious();
  }
}
