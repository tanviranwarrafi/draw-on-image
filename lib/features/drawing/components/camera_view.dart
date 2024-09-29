import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tutorial/themes/colors.dart';

class CameraView extends StatelessWidget {
  final CameraController controller;
  CameraView({required this.controller});

  @override
  Widget build(BuildContext context) {
    var radius = const Radius.circular(08);
    var borderSide = const BorderSide(width: 2, color: white);
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          child: ClipRRect(borderRadius: BorderRadius.circular(08), child: CameraPreview(controller)),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: radius),
              border: Border(left: borderSide, top: borderSide),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: radius),
              border: Border(right: borderSide, top: borderSide),
            ),
          ),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: radius),
              border: Border(left: borderSide, bottom: borderSide),
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: radius),
              border: Border(right: borderSide, bottom: borderSide),
            ),
          ),
        ),
      ],
    );
  }
}
