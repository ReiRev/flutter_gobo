import 'dart:async';

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:gobo/board.dart';
import 'package:gobo/stone.dart';
import "./utils.dart";

final addStream = StreamController<BoardAction>();
final removeStream = StreamController<Coordinate>();
StoneVariant turn = StoneVariant.black;

@widgetbook.UseCase(name: 'Board', type: Board)
Widget buildBoardUseCase(BuildContext context) {
  Board board = Board(
    width: context.knobs.double.slider(
      label: 'width',
      initialValue: 500,
      min: 0,
      max: 1000,
    ),
    backgroundColor: context.knobs.color(
      label: 'background color',
      initialValue: const Color.fromRGBO(214, 181, 105, 1),
    ),
    onPressed: (Coordinate coordinate) {
      addStream.sink.add(BoardAction(coordinate, turn));
      turn =
          turn == StoneVariant.black ? StoneVariant.white : StoneVariant.black;
      print(turn);
    },
    onDoublePressed: (Coordinate coordinate) => {
      removeStream.sink.add(coordinate),
    },
    onHover: (Coordinate coordinate) => {},
    addStream: addStream,
    removeStream: removeStream,
  );
  return board;
}
