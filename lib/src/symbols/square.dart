import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import 'dart:math';

class Square extends ShapeComponent {
  Square({
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

    final path = Path()
      // add minus sign to flip the triangle vertically
      ..moveTo(-radius / sqrt(2), radius / sqrt(2))
      ..lineTo(radius / sqrt(2), radius / sqrt(2))
      ..lineTo(radius / sqrt(2), -radius / sqrt(2))
      ..lineTo(-radius / sqrt(2), -radius / sqrt(2))
      ..close();

    canvas.drawPath(path, paint);
  }
}
