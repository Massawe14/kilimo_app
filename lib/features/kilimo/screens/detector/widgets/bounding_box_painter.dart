import 'package:flutter/material.dart';

class DetectionPainter extends CustomPainter {
  final List detectionResults;

  DetectionPainter(this.detectionResults);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    for (var result in detectionResults) {
      final rect = Rect.fromLTWH(
        result['x'],
        result['y'],
        result['width'],
        result['height'],
      );
      canvas.drawRect(rect, paint);
      TextSpan span = TextSpan(
        style: const TextStyle(color: Colors.white), 
        text: '${result['class_name']} (${result['score'].toStringAsFixed(2)})');
      TextPainter tp = TextPainter(
        text: span, 
        textAlign: TextAlign.left, 
        textDirection: TextDirection.ltr
      );
      tp.layout();
      tp.paint(canvas, Offset(result['x'], result['y']));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
