import 'package:flutter/material.dart';
import 'package:tutorial/themes/colors.dart';
import 'package:tutorial/themes/text_styles.dart';

class NotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 150),
          Icon(Icons.image, size: 72, color: primary.withOpacity(0.5)),
          const SizedBox(height: 08),
          Text('No Image Available', style: TextStyles.text22_600.copyWith(color: primary.withOpacity(0.8))),
        ],
      ),
    );
  }
}
