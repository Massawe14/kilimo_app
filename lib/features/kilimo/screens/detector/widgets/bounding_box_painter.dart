import 'package:flutter/material.dart';

class BoundingBoxPainter extends CustomPainter {
  final List<dynamic> recognitions;
  final double imageWidth;
  final double imageHeight;

  BoundingBoxPainter(this.recognitions, this.imageWidth, this.imageHeight);

  @override
  void paint(Canvas canvas, Size size) {
    if (recognitions.isEmpty) return;

    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    for (var recognition in recognitions) {
      Rect rect = recognition['rect'];
      canvas.drawRect(
        Rect.fromLTRB(
          rect.left,
          rect.top,
          rect.right,
          rect.bottom,
        ),
        paint,
      );

      TextSpan span = TextSpan(
        style: const TextStyle(
          color: Colors.red,
          fontSize: 12.0,
        ),
        text: '${recognition['label']} ${(recognition['score'] * 100).toStringAsFixed(2)}%',
      );
      TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, Offset(rect.left, rect.top));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
