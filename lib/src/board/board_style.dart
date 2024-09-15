import 'package:flutter/painting.dart';
import 'package:gobo/gobo.dart';

class BoardStyle {
  final Paint paint;
  final BoardAxisLabels labels;

  double lineThickness(BoardComponent board) {
    return board.width * 0.3 / 140 * 19 / board.boardSize;
  }

  double startPointRadius(BoardComponent board) {
    return board.width * 0.6 / 140 * 19 / board.boardSize;
  }

  double intersectionWidth(BoardComponent board) {
    return board.width / board.boardSize;
  }

  double intersectionHeight(BoardComponent board) {
    return board.width / board.boardSize;
  }

  double stoneRadius(BoardComponent board) {
    return board.width * 3.75 / 140 * 19 / board.boardSize;
  }

  bool isStarPoint(BoardComponent board, int x, int y) {
    List<int> lineIndices = board.boardSize >= 13
        ? [3, board.boardSize - 4]
        : [2, board.boardSize - 3];
    if (board.boardSize % 2 == 1) {
      lineIndices.add((board.boardSize / 2).floor());
    }
    if (lineIndices.contains(x) && lineIndices.contains(y)) {
      return true;
    }
    return false;
  }

  BoardStyle({
    required this.paint,
    this.labels = const BoardAxisLabels.none(),
  });
}
