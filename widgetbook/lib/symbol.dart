import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:gobo/gobo.dart' as gobo;

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

@widgetbook.UseCase(name: 'Triangle', type: ShapeComponent)
Widget buildWhiteStoneUseCase(BuildContext context) {
  return SymbolWrapper(
    symbol: gobo.Triangle(
      fill: context.knobs.boolean(label: 'fill', initialValue: true),
      color: context.knobs.color(label: 'color', initialValue: Colors.white),
    )
      ..debugMode =
          context.knobs.boolean(label: 'debug mode', initialValue: false)
      ..angle = context.knobs.double
          .slider(label: 'angle', initialValue: 0, min: 0, max: 360),
    // ..fill = context.knobs.boolean(label: 'fill', initialValue: true),
  );
}
