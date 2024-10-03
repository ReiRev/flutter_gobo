import 'package:flutter/painting.dart';
import 'symbol_component.dart';
import 'dart:math';

class Square extends SymbolComponent {
  Square({
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
      ..moveTo(-radius / sqrt(2), radius / sqrt(2))
      ..lineTo(radius / sqrt(2), radius / sqrt(2))
      ..lineTo(radius / sqrt(2), -radius / sqrt(2))
      ..lineTo(-radius / sqrt(2), -radius / sqrt(2))
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  String toString() {
    return 'Square';
  }
}
