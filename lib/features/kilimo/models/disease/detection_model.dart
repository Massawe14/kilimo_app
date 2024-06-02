import 'dart:ui';

class Detection {
  final String label;
  final double confidence;
  final Rect rect;

  Detection({
    required this.label, 
    required this.confidence, 
    required this.rect
  });

  factory Detection.fromJson(Map<String, dynamic> json) {
    return Detection(
      label: json['label'],
      confidence: json['confidence'],
      rect: Rect.fromLTWH(
        json['rect']['x'],
        json['rect']['y'],
        json['rect']['w'],
        json['rect']['h'],
      ),
    );
  }
}
