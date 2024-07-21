import 'package:flutter_test/flutter_test.dart';
import 'package:gobo/stone.dart';

void main() {
  testWidgets('Stone - Click Behavior', (WidgetTester tester) async {
    bool isPressed = false;
    var stones = <Stone>[
      Stone.black(
        radius: 10,
        onPressed: () {
          isPressed = true;
        },
      ),
      Stone.white(
        radius: 10,
        onPressed: () {
          isPressed = true;
        },
      ),
    ];

    for (var stone in stones) {
      isPressed = false;
      await tester.pumpWidget(stone);
      await tester.tap(find.byType(Stone));
      final stoneFinder = find.byType(Stone);
      expect(stoneFinder, findsOneWidget);
      await tester.pump();
      expect(isPressed, true);
    }
  });
}
