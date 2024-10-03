export 'symbol_component.dart';

import 'package:flutter/painting.dart';

import 'const.dart';
import 'triangle.dart';
import 'square.dart';
import 'circle.dart';

abstract final class Symbols {
  static var triangle = ({
    double radius = referenceSymbolRadius,
    Color color = const Color(0xFFFFFFFF),
    double strokeWidth = referenceSymbolStrokeWidth,
    bool fill = true,
    double angle = 0,
  }) =>
      Triangle(
        radius: radius,
        strokeWidth: strokeWidth,
        color: color,
        fill: fill,
        angle: angle,
      );

  static var circle = ({
    double radius = referenceSymbolRadius,
    Color color = const Color(0xFFFFFFFF),
    double strokeWidth = referenceSymbolStrokeWidth,
    bool fill = true,
    double angle = 0,
  }) =>
      Circle(
        radius: radius,
        strokeWidth: strokeWidth,
        color: color,
        fill: fill,
        angle: angle,
      );

  static var square = ({
    double radius = referenceSymbolRadius,
    Color color = const Color(0xFFFFFFFF),
    double strokeWidth = referenceSymbolStrokeWidth,
    bool fill = true,
    double angle = 0,
  }) =>
      Square(
        radius: radius,
        strokeWidth: strokeWidth,
        color: color,
        fill: fill,
        angle: angle,
      );
}
