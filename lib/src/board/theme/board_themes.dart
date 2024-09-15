import 'package:gobo/gobo.dart';
import 'package:flutter/painting.dart';

abstract class BoardThemes {
  static var basic = ({
    BoardAxisLabels? labels = const BoardAxisLabels.none(),
  }) =>
      BoardTheme(
        paint: Paint()..color = const Color.fromRGBO(214, 181, 105, 1),
        labels: labels ?? const BoardAxisLabels.none(),
      );

  static var book = ({
    BoardAxisLabels? labels = const BoardAxisLabels.none(),
  }) =>
      BoardBookTheme(
        labels: labels ?? const BoardAxisLabels.none(),
      );
}
