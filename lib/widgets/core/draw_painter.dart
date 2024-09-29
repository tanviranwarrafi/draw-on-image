import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:tutorial/models/drawing_point.dart';

class DrawPainter extends CustomPainter {
  final List<DrawingPoint> drawingPoints;
  final ui.Image image;

  DrawPainter({required this.drawingPoints, required this.image});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the original image
    canvas.drawImage(image, Offset.zero, Paint());

    // Draw the drawing points on top of the image
    final paint = Paint()..strokeCap = StrokeCap.round;
    for (var point in drawingPoints) {
      paint.color = point.color;
      paint.strokeWidth = point.width;
      for (int i = 0; i < point.offsets.length - 1; i++) {
        canvas.drawLine(point.offsets[i], point.offsets[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
