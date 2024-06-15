import 'package:flutter/material.dart';

import '../../../../../util/constants/colors.dart';

class BoundingBoxPainter extends CustomPainter {
  final List<dynamic>? results;

  BoundingBoxPainter(this.results);

  @override
  void paint(Canvas canvas, Size size) {
    if (results == null || results!.isEmpty) {
      return;
    }

    final paint = Paint()
      ..color = TColors.error
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    final textPainter = TextPainter(
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );

    for (var result in results!) {
      if (result is Map<String, dynamic>) {
        final rect = result['rect'] as Map<String, dynamic>;
        final detectedClass = result['detectedClass'].toString();

        final left = rect['x'] * size.width;
        final top = rect['y'] * size.height;
        final right = left + rect['w'] * size.width;
        final bottom = top + rect['h'] * size.height;

        final rectToDraw = Rect.fromLTRB(left, top, right, bottom);
        canvas.drawRect(rectToDraw, paint);

        // Draw label background
        final backgroundPaint = Paint()
          ..color = TColors.error
          ..style = PaintingStyle.fill;
        final labelRect = Rect.fromLTWH(left, top - 20, rect['w'] * size.width, 20);
        canvas.drawRect(labelRect, backgroundPaint);

        // Draw text
        textPainter.text = TextSpan(
          text: detectedClass,
          style: const TextStyle(
            color: TColors.white, 
            fontSize: 16,
          ),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(left, top - 20));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
