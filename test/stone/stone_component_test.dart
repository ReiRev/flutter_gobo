import 'package:flutter_test/flutter_test.dart';
import 'package:gobo/gobo.dart';

void main() {
  final List<StoneComponent> stones = [
    WikipediaBlackStone(),
    WikipediaWhiteStone()
  ];

  for (var stone in stones) {
    group(stone.toString(), () {
      test('should have a painter', () {
        expect(stone.painter, isNotNull);
      });
    });
  }
}
