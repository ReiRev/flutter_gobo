import 'package:flame/components.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flame_test/flame_test.dart';
import 'package:gobo/gobo.dart';

void main() {
  final Map<String, StoneComponent Function()> stoneCreators = {
    "invisible": () => Stones.invisible(),
    "black": () => Stones.black(),
    "white": () => Stones.white(),
    "wikipediaBlack": () => Stones.wikipediaBlack(),
    "wikipediaWhite": () => Stones.wikipediaWhite(),
  };

  stoneCreators.forEach((name, stoneCreator) {
    group(stoneCreator().toString(), () {
      test('should have a paint layers', () {
        expect(stoneCreator().paintLayers, isNotNull);
        expect(stoneCreator().paintLayers, isNotEmpty);
      });

      testGolden(
        'renders golden',
        (game) async {
          game.add(stoneCreator()
            ..radius = 50
            ..position = Vector2(50, 50));
        },
        size: Vector2(100, 100),
        goldenFile: '_goldens/$name.png',
      );
    });
  });
}
