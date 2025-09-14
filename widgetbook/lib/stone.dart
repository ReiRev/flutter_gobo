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

@widgetbook.UseCase(name: 'White Stone', type: StoneComponent)
Widget buildWhiteStoneUseCase(BuildContext context) {
  return StoneWrapper(
    stone: Stones.white()
      ..radius = context.knobs.double
          .slider(label: 'radius', initialValue: 50, min: 1, max: 1000)
      ..opacity = context.knobs.double
          .slider(label: 'opacity', initialValue: 1, min: 0, max: 1)
      ..debugMode =
          context.knobs.boolean(label: 'debug mode', initialValue: false)
      ..symbol = context.knobs.listOrNull(label: "symbol", options: [
        Symbols.circle(fill: false, color: Colors.black),
        Symbols.triangle(fill: false, color: Colors.black),
        Symbols.square(fill: false, color: Colors.black),
      ]),
  );
}

@widgetbook.UseCase(name: 'Black Stone', type: StoneComponent)
Widget buildBlackStoneUseCase(BuildContext context) {
  return StoneWrapper(
    stone: Stones.black()
      ..radius = context.knobs.double
          .slider(label: 'radius', initialValue: 50, min: 1, max: 1000)
      ..opacity = context.knobs.double
          .slider(label: 'opacity', initialValue: 1, min: 0, max: 1)
      ..debugMode =
          context.knobs.boolean(label: 'debug mode', initialValue: false)
      ..symbol = context.knobs.listOrNull(label: "symbol", options: [
        Symbols.circle(fill: false),
        Symbols.triangle(fill: false),
        Symbols.square(fill: false),
      ]),
  );
}

@widgetbook.UseCase(name: 'Wikipedia Black Stone', type: StoneComponent)
Widget buildWikipediaBlackStoneUseCase(BuildContext context) {
  return StoneWrapper(
    stone: Stones.wikipediaBlack()
      ..radius = context.knobs.double
          .slider(label: 'radius', initialValue: 50, min: 1, max: 1000)
      ..opacity = context.knobs.double
          .slider(label: 'opacity', initialValue: 1, min: 0, max: 1)
      ..debugMode =
          context.knobs.boolean(label: 'debug mode', initialValue: false)
      ..symbol = context.knobs.listOrNull(label: "symbol", options: [
        Symbols.circle(fill: false),
        Symbols.triangle(fill: false),
        Symbols.square(fill: false),
      ]),
  );
}

@widgetbook.UseCase(name: 'Wikipedia White Stone', type: StoneComponent)
Widget buildWikipediaWhiteStoneUseCase(BuildContext context) {
  return StoneWrapper(
    stone: Stones.wikipediaWhite()
      ..radius = context.knobs.double
          .slider(label: 'radius', initialValue: 50, min: 1, max: 1000)
      ..opacity = context.knobs.double
          .slider(label: 'opacity', initialValue: 1, min: 0, max: 1)
      ..debugMode =
          context.knobs.boolean(label: 'debug mode', initialValue: false)
      ..symbol = context.knobs.listOrNull(label: "symbol", options: [
        Symbols.circle(fill: false, color: Colors.black),
        Symbols.triangle(fill: false, color: Colors.black),
        Symbols.square(fill: false, color: Colors.black),
      ]),
  );
}

@widgetbook.UseCase(name: 'Invisible Stone', type: StoneComponent)
Widget buildInvisibleStoneUseCase(BuildContext context) {
  return StoneWrapper(
    stone: Stones.invisible()
      ..radius = context.knobs.double
          .slider(label: 'radius', initialValue: 50, min: 1, max: 1000)
      ..debugMode =
          context.knobs.boolean(label: 'debug mode', initialValue: false),
  );
}
