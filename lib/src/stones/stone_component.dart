import 'package:flame/components.dart';
import 'package:gobo/gobo.dart';

import './const.dart';

/// A component that represents a stone on the board.
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

  SymbolComponent? _symbol;

  /// The radius of the stone.
  @override
  set radius(double value) {
    scale = Vector2.all(value / referenceStoneRadius);
  }

  set symbol(SymbolComponent? symbol) {
    if (_symbol != null) {
      remove(_symbol!);
    }
    _symbol = symbol;
    if (_symbol != null) {
      add(_symbol!..position = Vector2.all(radius));
    }
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
