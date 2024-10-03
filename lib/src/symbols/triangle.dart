import 'symbol_component.dart';
import 'package:flutter/painting.dart';
import 'dart:math';

class Triangle extends SymbolComponent {
  Triangle({
    required super.radius,
    super.color = const Color(0xFFFFFFFF),
    super.strokeWidth = 2,
    super.fill = true,
    super.angle = 0,
  });

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

  @override
  String toString() {
    return 'Triangle';
  }
}
