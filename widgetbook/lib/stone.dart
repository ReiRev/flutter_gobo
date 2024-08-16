import 'package:flutter/material.dart';
import 'package:gobo/gobo.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:gobo/gobo.dart';
import "./utils.dart";

@widgetbook.UseCase(name: 'Empty Stone', type: Stone)
Widget buildEmptyStoneUseCase(BuildContext context) {
  return BoardConfig(
    dimension: BoardDimension(
      width: 500,
      stoneRadius: context.knobs.double
          .slider(label: 'radius', initialValue: 50, min: 1, max: 1000),
    ),
    child: EmptyStone(
      onPressed: () {
        popup(context, 'pressed');
      },
      onDoublePressed: () {
        popup(context, 'double pressed');
      },
    ),
  );
}

@widgetbook.UseCase(name: 'Black Stone', type: Stone)
Widget buildBlackStoneUseCase(BuildContext context) {
  return BoardConfig(
    dimension: BoardDimension(
      width: 500,
      stoneRadius: context.knobs.double
          .slider(label: 'radius', initialValue: 50, min: 1, max: 1000),
    ),
    child: BlackStone(
      opacity: context.knobs.double
          .slider(label: 'opacity', initialValue: 1, min: 0, max: 1),
      onPressed: () {
        popup(context, 'pressed');
      },
      onDoublePressed: () {
        popup(context, 'double pressed');
      },
    ),
  );
}

@widgetbook.UseCase(name: 'White Stone', type: Stone)
Widget buildWhiteStoneUseCase(BuildContext context) {
  return BoardConfig(
    dimension: BoardDimension(
      width: 500,
      stoneRadius: context.knobs.double
          .slider(label: 'radius', initialValue: 50, min: 1, max: 1000),
    ),
    child: WhiteStone(
      opacity: context.knobs.double
          .slider(label: 'opacity', initialValue: 1, min: 0, max: 1),
      onPressed: () {
        popup(context, 'pressed');
      },
      onDoublePressed: () {
        popup(context, 'double pressed');
      },
    ),
  );
}
