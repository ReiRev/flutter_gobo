import 'package:flame/components.dart';
import 'dart:ui';

abstract class StoneComponent extends CircleComponent with Snapshot {
  StoneComponent({
    super.radius,
    required this.painter,
  }) : super(anchor: Anchor.center);

  final Paint Function(double radius) painter;

  @override
  void render(Canvas canvas) {
    // assert(radius != null);
    canvas.drawCircle(
      Offset(radius, radius),
      radius,
      painter(radius),
    );
  }

  @override
  String toString();
}
