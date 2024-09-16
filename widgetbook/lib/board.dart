import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:gobo/gobo.dart';

class WikipediaBoard extends BoardComponent with TapCallbacks {
  WikipediaBoard({
    super.width,
    super.height,
    super.boardSize,
    super.theme,
  });

  bool isBlack = true;

  @override
  void onTapDown(TapDownEvent event) {
    putStone(
      isBlack ? Stones.wikipediaBlack() : Stones.wikipediaWhite(),
      eventPositionToCoordinate(event.localPosition),
    );
    isBlack = !isBlack;
  }
}

class BookBoard extends BoardComponent with TapCallbacks {
  BookBoard({
    super.width,
    super.height,
    super.boardSize,
    super.theme,
  });

  bool isBlack = true;

  @override
  void onTapDown(TapDownEvent event) {
    putStone(
      isBlack ? Stones.black() : Stones.white(),
      eventPositionToCoordinate(event.localPosition),
    );
    isBlack = !isBlack;
  }
}

@widgetbook.UseCase(name: 'Basic Board', type: BoardComponent)
Widget buildBoardUseCase(BuildContext context) {
  BoardComponent board = WikipediaBoard(
    width: context.knobs.double
        .slider(label: 'width', initialValue: 500, min: 1, max: 1000),
    height: context.knobs.double
        .slider(label: 'height', initialValue: 500, min: 1, max: 1000),
    boardSize: context.knobs.int
        .slider(label: 'board size', initialValue: 19, min: 1, max: 40),
  )..debugMode =
      context.knobs.boolean(label: 'debug mode', initialValue: false);

  return Gobo(board: board);
}

@widgetbook.UseCase(name: 'Book Board', type: BoardComponent)
Widget buildBookBoardUseCase(BuildContext context) {
  BoardComponent board = BookBoard(
    width: context.knobs.double
        .slider(label: 'width', initialValue: 500, min: 1, max: 1000),
    height: context.knobs.double
        .slider(label: 'height', initialValue: 500, min: 1, max: 1000),
    boardSize: context.knobs.int
        .slider(label: 'board size', initialValue: 19, min: 1, max: 40),
    theme: BoardThemes.book(),
  )..debugMode =
      context.knobs.boolean(label: 'debug mode', initialValue: false);

  return Gobo(board: board);
}

@widgetbook.UseCase(name: 'Labelled Board', type: BoardComponent)
Widget buildBoardWithLabelsUseCase(BuildContext context) {
  String labelBuilder(BoardAxisLabel? label) {
    if (label == null) {
      return "none";
    }
    final String i = label.indexToLabel(0);
    final String j = label.indexToLabel(1);
    final String k = label.indexToLabel(2);
    final String postfix = label.reversed ? '(reversed)' : '';
    return '$i $j $k ...$postfix';
  }

  List<BoardAxisLabel> options = [
    BoardAxisLabel.numerical(reversed: false),
    BoardAxisLabel.numerical(reversed: true),
    BoardAxisLabel.alphabetical(reversed: false),
    BoardAxisLabel.alphabetical(reversed: true),
    BoardAxisLabel.alphabetical(reversed: false, upperCase: false),
    BoardAxisLabel.alphabetical(reversed: true, upperCase: false),
  ];

  BoardComponent board = BoardComponent(
    width: context.knobs.double
        .slider(label: 'width', initialValue: 500, min: 1, max: 1000),
    height: context.knobs.double
        .slider(label: 'height', initialValue: 500, min: 1, max: 1000),
    boardSize: context.knobs.int
        .slider(label: 'board size', initialValue: 19, min: 1, max: 40),
    theme: BoardTheme(
      paint: Paint()..color = const Color.fromRGBO(214, 181, 105, 1),
      labels: BoardAxisLabels(
        top: context.knobs.listOrNull(
          label: "top label",
          options: options,
          labelBuilder: labelBuilder,
        ),
        bottom: context.knobs.listOrNull(
          label: "bottom label",
          options: options,
          labelBuilder: labelBuilder,
        ),
        right: context.knobs.listOrNull(
          label: "right label",
          options: options,
          labelBuilder: labelBuilder,
        ),
        left: context.knobs.listOrNull(
          label: "left label",
          options: options,
          labelBuilder: labelBuilder,
        ),
      ),
    ),
  )..debugMode =
      context.knobs.boolean(label: 'debug mode', initialValue: false);

  return Gobo(board: board);
}
