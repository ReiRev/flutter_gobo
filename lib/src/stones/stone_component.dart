import 'package:flame/components.dart';

import './const.dart';

class StoneComponent extends CircleComponent with Snapshot {
  StoneComponent({
    required super.paintLayers,
    double? radius,
  }) : super(
            anchor: Anchor.center,
            radius: referenceStoneRadius,
            scale: radius == null
                ? Vector2.all(1)
                : Vector2.all(radius / referenceStoneRadius));

  @override
  set radius(double value) {
    scale = Vector2.all(value / referenceStoneRadius);
  }

  // TODO: Do I really need to override this?
  @override
  set opacity(double value) {
    for (final paintLayer in paintLayers) {
      paintLayer.color = paintLayer.color.withOpacity(value);
    }
  }

  @override
  String toString();
}
