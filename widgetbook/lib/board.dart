import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:gobo/gobo.dart';
import 'package:golo/golo.dart' as golo;

class WidgetbookBoard extends BoardComponent with TapCallbacks {
  WidgetbookBoard({
    super.width,
    super.height,
    super.boardSize,
    super.theme,
  }) : game = golo.Game(boardSize: boardSize);

  bool isBlack = true;
  final golo.Game game;
  StoneComponent get blackStone => Stones.black();
  StoneComponent get whiteStone => Stones.white();

  @override
  void onTapDown(TapDownEvent event) {
    Coordinate coordinate = eventPositionToCoordinate(event.localPosition);
    try {
      game.play(
        isBlack ? golo.Player.black : golo.Player.white,
        coordinate.x,
        coordinate.y,
      );
      isBlack = !isBlack;
      putStone(
        isBlack ? blackStone : whiteStone,
        coordinate,
      );
      for (int x = 0; x < boardSize; x++) {
        for (int y = 0; y < boardSize; y++) {
          if (game.boardState.at(x, y) == golo.CoordinateStatus.empty &&
              stones[Coordinate(x, y)] != null) {
            removeStone(Coordinate(x, y));
          }
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}

class WikipediaBoard extends WidgetbookBoard {
  WikipediaBoard({
    super.width,
    super.height,
    super.boardSize,
    super.theme,
  });

  @override
  StoneComponent get blackStone => Stones.wikipediaBlack();
  @override
  StoneComponent get whiteStone => Stones.wikipediaWhite();
}

class BookBoard extends WidgetbookBoard {
  BookBoard({
    super.width,
    super.height,
    super.boardSize,
    super.theme,
  });

  @override
  StoneComponent get blackStone => Stones.black();
  @override
  StoneComponent get whiteStone => Stones.white();
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

  BoardComponent board = WikipediaBoard(
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
