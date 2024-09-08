import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:gobo/gobo.dart';

class MyBoardBloc extends BoardBloc {
  MyBoardBloc({
    required super.stoneOverlayBuilderMap,
  });

  bool isBlack = true;

  @override
  void onBoardTappedEvent(BoardInputEvent event, Emitter<BoardState> emit) {
    putStone(isBlack ? 'black' : 'white', event.coordinate, emit);
    isBlack = !isBlack;
  }

  @override
  void onBoardDoubleTappedEvent(
      BoardInputEvent event, Emitter<BoardState> emit) {
    removeStone(event.coordinate, emit);
  }
}

BoardBloc bloc = MyBoardBloc(
  stoneOverlayBuilderMap: {
    'black': () => WikipediaBlackStone(),
    'white': () => WikipediaWhiteStone(),
  },
);

@widgetbook.UseCase(name: 'Empty Board', type: BoardComponent)
Widget buildBoardUseCase(BuildContext context) {
  BoardComponent board = BoardComponent(
    size: context.knobs.double
        .slider(label: 'size', initialValue: 500, min: 1, max: 1000),
    boardSize: context.knobs.int
        .slider(label: 'board size', initialValue: 19, min: 1, max: 40),
  )..debugMode =
      context.knobs.boolean(label: 'debug mode', initialValue: false);

  return Gobo(board: board, boardBloc: bloc);
}
