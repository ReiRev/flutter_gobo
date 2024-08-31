import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:gobo/gobo.dart';

class StoneGame extends FlameGame {
  StoneGame({
    required this.stone,
  });

  final PositionComponent stone;

  @override
  Color backgroundColor() => const Color.fromRGBO(214, 181, 105, 1);

  @override
  Future<void> onLoad() async {
    world.add(stone);
    camera.follow(stone);
  }
}

class StoneWrapper extends StatelessWidget {
  const StoneWrapper({
    super.key,
    required this.stone,
  });

  final PositionComponent stone;

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: StoneGame(stone: stone),
    );
  }
}

@widgetbook.UseCase(name: 'Black Stone', type: StoneComponent)
Widget buildBlackStoneUseCase(BuildContext context) {
  return StoneWrapper(
    stone: WikipediaBlackStone(
      radius: context.knobs.double
          .slider(label: 'stoneRadius', initialValue: 50, min: 1, max: 1000),
      // onPressed: (_) => {popup(context, 'pressed')},
    )..debugMode =
        context.knobs.boolean(label: 'debug mode', initialValue: false),
  );
}

@widgetbook.UseCase(name: 'White Stone', type: StoneComponent)
Widget buildWhiteStoneUseCase(BuildContext context) {
  return StoneWrapper(
    stone: WikipediaWhiteStone(
      radius: context.knobs.double
          .slider(label: 'stoneRadius', initialValue: 50, min: 1, max: 1000),
    )..debugMode =
        context.knobs.boolean(label: 'debug mode', initialValue: false),
  );
}

@widgetbook.UseCase(name: 'Invisible Stone', type: StoneComponent)
Widget buildInvisibleStoneUseCase(BuildContext context) {
  return StoneWrapper(
    stone: InvisibleStone(
      radius: context.knobs.double
          .slider(label: 'stoneRadius', initialValue: 50, min: 1, max: 1000),
    )..debugMode =
        context.knobs.boolean(label: 'debug mode', initialValue: false),
  );
}
