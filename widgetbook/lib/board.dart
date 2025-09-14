import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:gobo/gobo.dart';
import 'package:golo/golo.dart' as golo;

class FreeBoard extends BoardComponent with TapCallbacks, DoubleTapCallbacks {
  FreeBoard({
    super.width,
    super.height,
    super.boardSize,
    super.theme,
  });

  bool isBlack = true;
  StoneComponent get blackStone => Stones.wikipediaBlack();
  StoneComponent get whiteStone => Stones.wikipediaWhite();

  @override
  void onTapUp(TapUpEvent event) {
    Coordinate coordinate = eventPositionToCoordinate(event.localPosition);
    try {
      isBlack = !isBlack;
      putStone(
        isBlack ? blackStone : whiteStone,
        coordinate,
      );
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  void onDoubleTapDown(DoubleTapDownEvent event) {
    Coordinate coordinate = eventPositionToCoordinate(event.localPosition);
    try {
      removeStone(coordinate);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}

@widgetbook.UseCase(name: 'Free Board', type: BoardComponent)
Widget buildFreeBoardUseCase(BuildContext context) {
  BoardComponent board = FreeBoard(
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

class WidgetbookBoard extends BoardComponent with TapCallbacks {
  WidgetbookBoard({
    super.width,
    super.height,
    super.boardSize,
    super.theme,
  }) : game = golo.Game(width: boardSize);

  final golo.Game game;
  StoneComponent get blackStone => Stones.black();
  StoneComponent get whiteStone => Stones.white();

  @override
  void onTapDown(TapDownEvent event) {
    Coordinate coordinate = eventPositionToCoordinate(event.localPosition);
    try {
      game.play((
        x: coordinate.x,
        y: coordinate.y,
      ));
      putStone(
        game.currentPlayer == golo.Stone.black ? blackStone : whiteStone,
        coordinate,
      );
      for (var y = 0; y < game.board.height; y++) {
        for (var x = 0; x < game.board.width; x++) {
          if (game.board.state[y][x] == null &&
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
        top: context.knobs.objectOrNull.dropdown<BoardAxisLabel>(
          label: 'top label',
          options: options,
          labelBuilder: labelBuilder,
        ),
        bottom: context.knobs.objectOrNull.dropdown<BoardAxisLabel>(
          label: 'bottom label',
          options: options,
          labelBuilder: labelBuilder,
        ),
        right: context.knobs.objectOrNull.dropdown<BoardAxisLabel>(
          label: 'right label',
          options: options,
          labelBuilder: labelBuilder,
        ),
        left: context.knobs.objectOrNull.dropdown<BoardAxisLabel>(
          label: 'left label',
          options: options,
          labelBuilder: labelBuilder,
        ),
      ),
    ),
  )..debugMode =
      context.knobs.boolean(label: 'debug mode', initialValue: false);

  return Gobo(board: board);
}
