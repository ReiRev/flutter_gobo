import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import 'dart:math';

class Triangle extends ShapeComponent {
  Triangle({
    this.color = const Color(0xFFFFFFFF),
    this.strokeWidth = 2,
    this.fill = true,
    super.angle = 0,
  });

  final Color color;
  final double strokeWidth;
  final bool fill;

  // set fill(bool value) {
  //   fill = value;
  // }

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = 2;

    double size = 100;
    final path = Path()
      // add minus sign to flip the triangle vertically
      ..moveTo(size * cos(pi * 90 / 180), -size * sin(pi * 90 / 180))
      ..lineTo(size * cos(pi * 210 / 180), -size * sin(pi * 210 / 180))
      ..lineTo(size * cos(pi * 330 / 180), -size * sin(pi * 330 / 180))
      ..close();

    canvas.drawPath(path, paint);
  }
}
