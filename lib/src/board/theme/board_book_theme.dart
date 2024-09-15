import 'dart:ui';

import 'package:gobo/gobo.dart';

class BoardBookTheme extends BoardTheme {
  BoardBookTheme({
    BoardAxisLabels? labels = const BoardAxisLabels.none(),
  }) : super(
          paint: Paint()..color = const Color.fromRGBO(255, 255, 255, 1),
          labels: labels ?? const BoardAxisLabels.none(),
        );

  @override
  double lineThickness(BoardComponent board, {int? x, int? y}) {
    if (x == 0 ||
        y == 0 ||
        x == board.boardSize - 1 ||
        y == board.boardSize - 1) {
      return board.width * 0.6 / 140 * 19 / board.boardSize;
    }
    return board.width * 0.3 / 140 * 19 / board.boardSize;
  }
}
