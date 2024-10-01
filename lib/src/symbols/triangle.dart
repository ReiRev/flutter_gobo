import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import 'dart:math';

class Triangle extends ShapeComponent {
  Triangle({
    required this.radius,
    this.color = const Color(0xFFFFFFFF),
    this.strokeWidth = 2,
    this.fill = true,
    super.angle = 0,
  });

  final double radius;
  final Color color;
  final double strokeWidth;
  final bool fill;

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final path = Path()
      // add minus sign to flip the triangle vertically
      ..moveTo(radius * cos(pi * 90 / 180), -radius * sin(pi * 90 / 180))
      ..lineTo(radius * cos(pi * 210 / 180), -radius * sin(pi * 210 / 180))
      ..lineTo(radius * cos(pi * 330 / 180), -radius * sin(pi * 330 / 180))
      ..close();

    canvas.drawPath(path, paint);
  }
}
