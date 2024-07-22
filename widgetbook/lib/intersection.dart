import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:gobo/intersection.dart';
import 'package:gobo/stone.dart';
import "./utils.dart";

@widgetbook.UseCase(name: 'Intersection', type: Intersection)
Widget buildIntersectionUseCase(BuildContext context) {
  return Container(
      color: context.knobs.color(
          label: 'container color',
          initialValue: const Color.fromRGBO(214, 181, 105, 1)),
      child: Intersection(
          height: context.knobs.double
              .slider(label: 'height', initialValue: 100, min: 1, max: 1000),
          width: context.knobs.double
              .slider(label: 'width', initialValue: 100, min: 1, max: 1000),
          lineThickness: context.knobs.double.slider(
              label: 'lineThickness', initialValue: 1, min: 1, max: 100),
          isTopMost:
              context.knobs.boolean(label: 'isTopMost', initialValue: false),
          isBottomMost:
              context.knobs.boolean(label: 'isBottomMost', initialValue: false),
          isLeftMost:
              context.knobs.boolean(label: 'isLeftMost', initialValue: false),
          isRightMost:
              context.knobs.boolean(label: 'isRightMost', initialValue: false),
          isStarPoint:
              context.knobs.boolean(label: 'isStarPoint', initialValue: false),
          starPointRadius: context.knobs.double.slider(
              label: 'starPointRadius', initialValue: 3, min: 1, max: 100),
          onPressed: () => popup(context, 'pressed'),
          onDoublePressed: () => popup(context, 'double pressed'),
          stone: context.knobs.listOrNull(
            label: 'stone',
            options: [
              Stone.black(
                radius: context.knobs.double.slider(
                    label: 'stone radius', initialValue: 50, min: 1, max: 1000),
                opacity: 1,
                onPressed: () => popup(context, 'stone pressed'),
                onDoublePressed: () => popup(context, 'stone double pressed'),
              ),
              Stone.white(
                radius: context.knobs.double.slider(
                    label: 'stone radius', initialValue: 50, min: 1, max: 1000),
                opacity: 1,
                onPressed: () => popup(context, 'stone pressed'),
                onDoublePressed: () => popup(context, 'stone double pressed'),
              ),
            ],
            labelBuilder: (Stone? stone) => stone.toString(),
          )));
}
