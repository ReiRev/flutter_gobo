import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class SymbolComponent extends ShapeComponent {
  SymbolComponent({
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
  String toString() {
    return 'SymbolComponent';
  }
}
