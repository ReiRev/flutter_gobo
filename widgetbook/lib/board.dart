import 'package:flutter/material.dart';
import 'package:gobo/gobo.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import "./utils.dart";

enum Player {
  black,
  white,
}

extension PlayerX on Player {
  Player get opponent => this == Player.black ? Player.white : Player.black;

  Stone get stone =>
      this == Player.black ? const BlackStone() : const WhiteStone();
}

@widgetbook.UseCase(name: 'Empty Board', type: Board)
Widget buildEmptyBoardUseCase(BuildContext context) {
  return Board(
    dimension: BoardDimension(
      width: 500,
      stoneRadius: context.knobs.double
          .slider(label: 'radius', initialValue: 50, min: 1, max: 1000),
    ),
    theme: BoardTheme(
      boardColor: context.knobs.color(
        label: 'container color',
        initialValue: const Color.fromRGBO(214, 181, 105, 1),
      ),
    ),
    onStonePressed: (event, emit, state) {
      popup(context, 'pressed (${event.x}, ${event.y})');
    },
    onStoneDoublePressed: (event, emit, state) {
      popup(context, 'double pressed (${event.x}, ${event.y})');
    },
  );
}

@widgetbook.UseCase(name: 'Alternating Stone Board', type: Board)
Widget buildAlternatingStoneBoardUseCase(BuildContext context) {
  Player player = Player.black;

  return Board(
    dimension: BoardDimension(
      width: 500,
      stoneRadius: context.knobs.double
          .slider(label: 'radius', initialValue: 50, min: 1, max: 1000),
    ),
    theme: BoardTheme(
      boardColor: context.knobs.color(
        label: 'container color',
        initialValue: const Color.fromRGBO(214, 181, 105, 1),
      ),
    ),
    onStonePressed: (event, emit, state) {
      emit(state.added(event.x, event.y, player.stone));
      player = player.opponent;
    },
    onStoneDoublePressed: (event, emit, state) {
      emit(state.removed(event.x, event.y));
    },
  );
}
