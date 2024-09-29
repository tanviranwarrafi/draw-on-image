import 'package:flutter/material.dart';
import 'package:tutorial/components/buttons/elevate_button.dart';
import 'package:tutorial/di.dart';
import 'package:tutorial/extensions/flutter_ext.dart';
import 'package:tutorial/themes/colors.dart';
import 'package:tutorial/themes/text_styles.dart';
import 'package:tutorial/themes/transitions.dart';
import 'package:tutorial/utils/assets.dart';
import 'package:tutorial/utils/dimensions.dart';
import 'package:tutorial/utils/keys.dart';
import 'package:tutorial/widgets/core/pop_scope_navigator.dart';

Future<void> noCameraDialog() async {
  var context = navigatorKey.currentState!.context;
  await showGeneralDialog(
    context: context,
    barrierLabel: 'No Camera Dialog',
    transitionDuration: DIALOG_DURATION,
    transitionBuilder: sl<Transitions>().topToBottom,
    pageBuilder: (buildContext, anim1, anim2) => PopScopeNavigator(canPop: false, child: Align(child: _DialogView())),
  );
}

class _DialogView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.dialog_width,
      padding: EdgeInsets.symmetric(horizontal: Dimensions.dialog_padding, vertical: Dimensions.dialog_padding),
      decoration: BoxDecoration(color: white, borderRadius: DIALOG_RADIUS),
      child: Material(color: transparent, child: _screenView(context), shape: DIALOG_SHAPE),
    );
  }

  Widget _screenView(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        Image.asset(Assets.png_image.no_camera, height: 140),
        const SizedBox(height: 32),
        Text('No Camera Found!', textAlign: TextAlign.center, style: TextStyles.text22_600.copyWith(color: dark)),
        const SizedBox(height: 08),
        Text(
          'Sorry! we could not locate any camera in your device. Please try again',
          textAlign: TextAlign.center,
          style: TextStyles.text15_400.copyWith(color: grey2),
        ),
        const SizedBox(height: 28),
        ElevateButton(label: 'Go Back', width: double.infinity, onTap: _onBack),
        const SizedBox(height: 8),
      ],
    );
  }

  void _onBack() {
    backToPrevious();
    backToPrevious();
  }
}
