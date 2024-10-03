import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:gobo/gobo.dart';

class SymbolGame extends FlameGame {
  SymbolGame({
    required this.symbol,
  });

  final ShapeComponent symbol;

  @override
  Color backgroundColor() => const Color.fromRGBO(214, 181, 105, 1);

  @override
  Future<void> onLoad() async {
    world.add(symbol);
    camera.follow(symbol);
  }
}

class SymbolWrapper extends StatelessWidget {
  const SymbolWrapper({
    super.key,
    required this.symbol,
  });

  final ShapeComponent symbol;

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: SymbolGame(symbol: symbol),
    );
  }
}

@widgetbook.UseCase(name: 'Triangle', type: SymbolComponent)
Widget buildTriangleUseCase(BuildContext context) {
  return SymbolWrapper(
    symbol: Symbols.triangle(
      radius: context.knobs.double
          .slider(label: 'radius', initialValue: 100, min: 1, max: 1000),
      fill: context.knobs.boolean(label: 'fill', initialValue: true),
      color: context.knobs.color(label: 'color', initialValue: Colors.white),
      strokeWidth: context.knobs.double
          .slider(label: 'stroke width', initialValue: 2, min: 0, max: 100),
    )
      ..debugMode =
          context.knobs.boolean(label: 'debug mode', initialValue: false)
      ..angle = context.knobs.double
          .slider(label: 'angle', initialValue: 0, min: 0, max: 360),
    // ..fill = context.knobs.boolean(label: 'fill', initialValue: true),
  );
}

@widgetbook.UseCase(name: 'Circle', type: SymbolComponent)
Widget buildCircleUseCase(BuildContext context) {
  return SymbolWrapper(
    symbol: Symbols.circle(
      radius: context.knobs.double
          .slider(label: 'radius', initialValue: 100, min: 1, max: 1000),
      fill: context.knobs.boolean(label: 'fill', initialValue: true),
      color: context.knobs.color(label: 'color', initialValue: Colors.white),
      strokeWidth: context.knobs.double
          .slider(label: 'stroke width', initialValue: 2, min: 0, max: 100),
    )
      ..debugMode =
          context.knobs.boolean(label: 'debug mode', initialValue: false)
      ..angle = context.knobs.double
          .slider(label: 'angle', initialValue: 0, min: 0, max: 360),
    // ..fill = context.knobs.boolean(label: 'fill', initialValue: true),
  );
}

@widgetbook.UseCase(name: 'Square', type: SymbolComponent)
Widget buildSquareUseCase(BuildContext context) {
  return SymbolWrapper(
    symbol: Symbols.square(
      radius: context.knobs.double
          .slider(label: 'radius', initialValue: 100, min: 1, max: 1000),
      fill: context.knobs.boolean(label: 'fill', initialValue: true),
      color: context.knobs.color(label: 'color', initialValue: Colors.white),
      strokeWidth: context.knobs.double
          .slider(label: 'stroke width', initialValue: 2, min: 0, max: 100),
    )
      ..debugMode =
          context.knobs.boolean(label: 'debug mode', initialValue: false)
      ..angle = context.knobs.double
          .slider(label: 'angle', initialValue: 0, min: 0, max: 360),
    // ..fill = context.knobs.boolean(label: 'fill', initialValue: true),
  );
}
