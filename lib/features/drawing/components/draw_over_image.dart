import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:tutorial/components/buttons/elevate_button.dart';
import 'package:tutorial/di.dart';
import 'package:tutorial/extensions/flutter_ext.dart';
import 'package:tutorial/extensions/number_ext.dart';
import 'package:tutorial/features/drawing/components/wrap_colors_list.dart';
import 'package:tutorial/models/drawing_point.dart';
import 'package:tutorial/services/image_service.dart';
import 'package:tutorial/themes/colors.dart';
import 'package:tutorial/utils/assets.dart';
import 'package:tutorial/widgets/core/draw_painter.dart';
import 'package:tutorial/widgets/core/vertical_slider.dart';

class DrawingRoom extends StatefulWidget {
  final bool isPencil;
  final File image;
  final VoidCallback? onClear;
  final Function(List<DrawingPoint>) onUpdate;

  DrawingRoom({required this.image, required this.onUpdate, this.isPencil = true, this.onClear, Key? key}) : super(key: key);

  @override
  State<DrawingRoom> createState() => DrawingRoomState();
}

class DrawingRoomState extends State<DrawingRoom> {
  var _color = black;
  var _width = 8.0;
  var _isPencil = false;
  var _pointHistories = <DrawingPoint>[];
  var _drawingPoints = <DrawingPoint>[];
  DrawingPoint? _drawPoint;
  ui.Image? _uiImage;

  @override
  void initState() {
    _drawingPoints.clear();
    _pointHistories.clear();
    _isPencil = widget.isPencil;
    setState(() {});
    _fileToUiImage();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DrawingRoom oldWidget) {
    setState(() => _isPencil = widget.isPencil);
    _fileToUiImage();
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _fileToUiImage() async {
    var renderedImage = await sl<ImageService>().fileToUiImage(widget.image);
    setState(() => _uiImage = renderedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_uiImage != null)
          FittedBox(
            child: GestureDetector(
              onPanStart: !_isPencil ? null : _onPanStart,
              onPanUpdate: !_isPencil ? null : _onPenUpdate,
              onPanEnd: !_isPencil ? null : (_) => _drawPoint = null,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CustomPaint(
                  painter: DrawPainter(drawingPoints: _drawingPoints, image: _uiImage!),
                  size: Size(_uiImage!.width.toDouble(), _uiImage!.height.toDouble()),
                ),
              ),
            ),
          ),
        if (_isPencil) Positioned(top: 08, left: 10, child: WrapColorsList(selectedItem: _color, onSelect: _onColor)),
        if (_isPencil) Positioned(right: 0, bottom: 16, child: VerticalSlider(height: 36.height, value: _width, onChanged: _onWidth)),
        if (_isPencil)
          Positioned(left: 0, right: 0, bottom: 04, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: _drawActionList)),
      ],
    );
  }

  void _onColor(Color item) => setState(() => _color = item);

  void _onWidth(double item) => setState(() => _width = item);

  void _onPanStart(DragStartDetails details) {
    var id = currentDate.microsecondsSinceEpoch;
    _drawPoint = DrawingPoint(id: id, offsets: [details.localPosition], color: _color, width: _width);
    if (_drawPoint == null) setState(() {});
    _drawingPoints.add(_drawPoint!);
    _pointHistories = List.of(_drawingPoints);
    setState(() {});
    widget.onUpdate(_drawingPoints);
  }

  void _onPenUpdate(DragUpdateDetails details) {
    if (_drawPoint == null) setState(() {});
    _drawPoint = _drawPoint?.copyWith(offsets: _drawPoint!.offsets..add(details.localPosition));
    _drawingPoints.last = _drawPoint!;
    _pointHistories = List.of(_drawingPoints);
    setState(() {});
    widget.onUpdate(_drawingPoints);
  }

  List<Widget> get _drawActionList {
    var isUndo = _drawingPoints.isNotEmpty && _pointHistories.isNotEmpty;
    var isRedo = _drawingPoints.length < _pointHistories.length;
    var isClear = _drawingPoints.isNotEmpty || _pointHistories.isNotEmpty;
    return [
      _Button(label: 'Undo', icon: Assets.svg.arrow_elbow_up_left, status: isUndo, onTap: !isUndo ? null : _onUndo),
      const SizedBox(width: 04),
      _Button(status: isRedo, label: 'Redo', icon: Assets.svg.arrow_elbow_up_right, onTap: !isRedo ? null : _onRedo),
      const SizedBox(width: 04),
      _Button(label: 'Clear', icon: Assets.svg.close, status: isClear, onTap: !isClear ? null : onClear),
    ];
  }

  void _onUndo() {
    _drawingPoints.removeLast();
    setState(() {});
    widget.onUpdate(_drawingPoints);
  }

  void _onRedo() {
    _drawingPoints.add(_pointHistories[_drawingPoints.length]);
    setState(() {});
    widget.onUpdate(_drawingPoints);
  }

  void onClear() {
    _drawingPoints.clear();
    _pointHistories.clear();
    setState(() {});
    widget.onUpdate(_drawingPoints);
  }
}

class _Button extends StatelessWidget {
  final String label;
  final String icon;
  final bool status;
  final Function()? onTap;

  const _Button({required this.icon, this.label = '', this.status = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevateButton(
      height: 28,
      padding: 06,
      radius: 06,
      iconSize: 16,
      textSize: 13,
      label: label,
      icon: icon,
      color: !status ? grey2 : offWhite4,
      background: !status ? grey3 : grey2,
      onTap: !status || onTap == null ? null : onTap,
    );
  }
}
