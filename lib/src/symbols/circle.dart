import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class Circle extends ShapeComponent {
  Circle({
    required this.radius,
    this.color = const Color(0xFFFFFFFF),
    this.strokeWidth = 2,
    this.fill = true,
    super.angle = 0,
  });

  final Color color;
  final double strokeWidth;
  final bool fill;
  final double radius;

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    var radius = 100.0;
    canvas.drawCircle(const Offset(0, 0), radius, paint);
  }
}
