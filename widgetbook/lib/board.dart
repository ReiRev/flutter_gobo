import 'package:bloc/bloc.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:gobo/src/models/coordinate.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:gobo/gobo.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:gobo/src/bloc/board_bloc.dart';

class BoardGame extends FlameGame {
  BoardGame({
    required this.board,
  });

  final BoardComponent board;

  Map<Coordinate, StoneComponent> stones = {};

  @override
  Future<void> onLoad() async {
    // world.add(board);
    // final stone = InvisibleStone();
    // board.addStone(
    //   const Coordinate(10, 10),
    //   InvisibleStone(),
    // );
    world.add(
      FlameBlocProvider<BoardBloc, BoardState>.value(
        value: BoardBloc(),
        children: [board],
      ),
    );
    camera.follow(board);
  }
}

class BoardWrapper extends StatelessWidget {
  const BoardWrapper({
    super.key,
    required this.board,
  });

  final BoardComponent board;

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: BoardGame(board: board),
    );
  }
}

@widgetbook.UseCase(name: 'Empty Board', type: BoardComponent)
Widget buildBoardUseCase(BuildContext context) {
  return BoardWrapper(
    board: BoardComponent(
      size: context.knobs.double
          .slider(label: 'size', initialValue: 500, min: 1, max: 1000),
      boardSize: context.knobs.int
          .slider(label: 'board size', initialValue: 19, min: 1, max: 40),
    )..debugMode =
        context.knobs.boolean(label: 'debug mode', initialValue: false),
  );
}
