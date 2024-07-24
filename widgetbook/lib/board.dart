import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:gobo/board.dart';

@widgetbook.UseCase(name: 'Board', type: Board)
Widget buildBoardUseCase(BuildContext context) {
  return Board(
      width: context.knobs.double.slider(
        label: 'width',
        initialValue: 500,
        min: 0,
        max: 1000,
      ),
      backgroundColor: context.knobs.color(
        label: 'background color',
        initialValue: const Color.fromRGBO(214, 181, 105, 1),
      ));
}
