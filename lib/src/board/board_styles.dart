import 'package:gobo/gobo.dart';
import 'package:flutter/painting.dart';

abstract class BoardStyles {
  static var basic = () => BoardStyle(
        paint: Paint()..color = const Color.fromRGBO(214, 181, 105, 1),
        labels: const BoardAxisLabels.none(),
      );
}
