import 'package:flame/components.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flame_test/flame_test.dart';
import 'package:gobo/gobo.dart';

void main() {
  final List<StoneComponent Function()> stoneCreators = [
    () => InvisibleStone(),
    () => WikipediaBlackStone(),
    () => WikipediaWhiteStone()
  ];

  for (var stoneCreator in stoneCreators) {
    group(stoneCreator().toString(), () {
      test('should have a painter', () {
        expect(stoneCreator().painter, isNotNull);
      });

      testGolden(
        'renders golden',
        (game) async {
          game.add(stoneCreator()
            ..radius = 50
            ..position = Vector2(50, 50));
        },
        size: Vector2(100, 100),
        goldenFile: '_goldens/${stoneCreator().toString()}.png',
      );
    });
  }
}
