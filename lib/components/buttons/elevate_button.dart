import 'package:flutter/material.dart';
import 'package:tutorial/themes/colors.dart';
import 'package:tutorial/themes/text_styles.dart';
import 'package:tutorial/widgets/library/svg_image.dart';

class ElevateButton extends StatelessWidget {
  final String label;
  final String? icon;
  final double? width;
  final double height;
  final double radius;
  final Color color;
  final Color background;
  final double padding;
  final double iconSize;
  final double textSize;
  final Function()? onTap;

  const ElevateButton({
    this.label = '',
    this.width,
    this.icon,
    this.onTap,
    this.radius = 08,
    this.height = 48,
    this.padding = 12,
    this.color = white,
    this.iconSize = 20,
    this.textSize = 15,
    this.background = primary,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: padding),
        decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(radius)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) SvgImage(image: icon!, height: iconSize, color: color),
            if (icon != null) const SizedBox(width: 08),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.text15_500.copyWith(color: color, fontSize: textSize),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
