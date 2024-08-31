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

  // @override
  // String toString();

  // TODO: enforce to assign coordinate
  // TODO: enforce to wrap with FlameBlocProvider
  // @override
  // void onTapDown(TapDownEvent event) {
  //   if (bloc != null && coordinate != null) {
  //     bloc?.add(TappedDown(coordinate!));
  //   }
  // }
}
