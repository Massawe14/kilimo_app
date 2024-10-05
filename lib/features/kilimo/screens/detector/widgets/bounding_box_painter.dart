import 'package:flutter/material.dart';

class ObjectDetectionPainter extends CustomPainter {
  final List<dynamic> detectedObjects;

  ObjectDetectionPainter(this.detectedObjects);

  @override
  void paint(Canvas canvas, Size size) {
    for (var obj in detectedObjects) {
      var rect = obj['box'];
      var paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..color = Colors.red;
      canvas.drawRect(
        Rect.fromLTWH(
          rect[0] * size.width,
          rect[1] * size.height,
          (rect[2] - rect[0]) * size.width,
          (rect[3] - rect[1]) * size.height,
        ),
        paint,
      );
      var textPainter = TextPainter(
        text: TextSpan(
          text: '${obj['name']} ${(obj['conf'] * 100).toStringAsFixed(0)}%',
          style: const TextStyle(
            color: Colors.red,
            fontSize: 14.0,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(rect[0] * size.width, rect[1] * size.height - 20),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
