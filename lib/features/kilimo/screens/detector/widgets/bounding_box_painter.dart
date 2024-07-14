import 'package:flutter/material.dart';

class ObjectDetectionPainter extends CustomPainter {
  final List<dynamic> detectedObjects;

  ObjectDetectionPainter(this.detectedObjects);

  @override
  void paint(Canvas canvas, Size size) {
    for (var obj in detectedObjects) {
      var rect = obj['rect'];
      var paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..color = Colors.red;
      canvas.drawRect(
        Rect.fromLTWH(
          rect['x'] * size.width,
          rect['y'] * size.height,
          rect['w'] * size.width,
          rect['h'] * size.height,
        ),
        paint,
      );
      var textPainter = TextPainter(
        text: TextSpan(
          text: '${obj['detectedClass']} ${(obj['confidenceInClass'] * 100).toStringAsFixed(0)}%',
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
        Offset(rect['x'] * size.width, rect['y'] * size.height - 20),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
