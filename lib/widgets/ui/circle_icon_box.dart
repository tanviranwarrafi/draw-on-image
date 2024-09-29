import 'package:flutter/material.dart';
import 'package:tutorial/themes/colors.dart';

class CircleIconBox extends StatelessWidget {
  final Color border;
  final double size;
  final Widget icon;
  final Color background;
  final Function()? onTap;

  const CircleIconBox({
    this.icon = const SizedBox.shrink(),
    this.onTap,
    this.border = transparent,
    this.background = transparent,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        child: icon,
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: background, shape: BoxShape.circle, border: Border.all(color: border)),
      ),
    );
  }
}
