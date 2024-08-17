import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:gobo/gobo.dart';

@widgetbook.UseCase(name: 'Intersection', type: Intersection)
Widget buildIntersectionUseCase(BuildContext context) {
  return BoardConfig(
    dimension: BoardDimension(
      width: context.knobs.double
          .slider(label: 'board width', initialValue: 1000, min: 1, max: 10000),
    ),
    child: Container(
      color: context.knobs.color(
        label: 'container color',
        initialValue: const Color.fromRGBO(214, 181, 105, 1),
      ),
      child: Intersection(
        x: context.knobs.int
            .slider(label: 'x', initialValue: 0, min: 0, max: 18),
        y: context.knobs.int
            .slider(label: 'y', initialValue: 0, min: 0, max: 18),
        stone: context.knobs.list<Stone>(
          label: 'stone',
          options: <Stone>[
            const EmptyStone(),
            const BlackStone(),
            const WhiteStone(),
          ],
          labelBuilder: (Stone? stone) {
            switch (stone.runtimeType) {
              case EmptyStone:
                return 'Empty Stone';
              case BlackStone:
                return 'Black Stone';
              case WhiteStone:
                return 'White Stone';
              default:
                throw Exception('Unknown stone type');
            }
          },
        ),
      ),
    ),
  );
}
