import 'package:flutter/painting.dart';
import 'symbol_component.dart';

class Circle extends SymbolComponent {
  Circle({
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
    canvas.drawCircle(const Offset(0, 0), radius, paint);
  }

  @override
  String toString() {
    return 'Circle';
  }
}
