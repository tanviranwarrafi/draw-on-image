# Draw On Image

Draw Pointer
```dart
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
```

When start drawing
```dart
  void _onPanStart(DragStartDetails details) {
    var id = currentDate.microsecondsSinceEpoch;
    _drawPoint = DrawingPoint(id: id, offsets: [details.localPosition], color: _color, width: _width);
    _drawingPoints.add(_drawPoint!);
    _pointHistories = List.of(_drawingPoints);
  }
```
Update drawing
```dart
  void _onPenUpdate(DragUpdateDetails details) {
    _drawPoint = _drawPoint?.copyWith(offsets: _drawPoint!.offsets..add(details.localPosition));
    _drawingPoints.last = _drawPoint!;
    _pointHistories = List.of(_drawingPoints);
  }
```

## Screenshot
<img src="screenshot/one.png"> 
