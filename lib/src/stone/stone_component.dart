import 'package:flame/components.dart';
import 'dart:ui';

import 'package:gobo/src/models/coordinate.dart';

abstract class StoneComponent extends CircleComponent with Snapshot {
  StoneComponent({
    super.radius,
    required this.painter,
    this.coordinate,
  }) : super(anchor: Anchor.center);

  Coordinate? coordinate;
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
}
