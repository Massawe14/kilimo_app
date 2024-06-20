import 'package:flutter/material.dart';

import '../../../../../util/constants/colors.dart';

class BoundingBoxPainter extends CustomPainter {
  final List<dynamic> results;

  BoundingBoxPainter(this.results);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = TColors.error
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    for (var result in results) {
      final rect = Rect.fromLTWH(
        result["rect"]["x"] * size.width,
        result["rect"]["y"] * size.height,
        result["rect"]["w"] * size.width,
        result["rect"]["h"] * size.height,
      );

      canvas.drawRect(rect, paint);

      final textPainter = TextPainter(
        text: TextSpan(
          text: "${result["detectedClass"]} ${(result["confidenceInClass"] * 100).toStringAsFixed(0)}%",
          style: const TextStyle(
            color: TColors.error,
            fontSize: 14,
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );

      textPainter.paint(canvas, Offset(rect.left, rect.top));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
