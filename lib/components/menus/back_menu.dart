import 'package:flutter/material.dart';
import 'package:tutorial/extensions/flutter_ext.dart';
import 'package:tutorial/themes/colors.dart';
import 'package:tutorial/utils/assets.dart';
import 'package:tutorial/widgets/library/svg_image.dart';

class BackMenu extends StatelessWidget {
  final double size;
  final double iconSize;
  final Color iconColor;
  final Color background;
  final Color border;
  final Function()? onTap;

  const BackMenu({
    this.size = 36,
    this.iconSize = 20,
    this.onTap,
    this.border = transparent,
    this.iconColor = grey2,
    this.background = offWhite2,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? backToPrevious,
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: background, shape: BoxShape.circle, border: Border.all(color: border)),
        child: SvgImage(image: Assets.svg.arrow_left, color: iconColor, height: iconSize),
      ),
    );
  }
}
