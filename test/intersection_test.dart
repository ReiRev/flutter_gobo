import 'package:flutter_test/flutter_test.dart';
import 'package:gobo/intersection.dart';

void main() {
  testWidgets('Intersection - Click Behavior', (WidgetTester tester) async {
    bool isPressed = false;
    final intersection = Intersection(
      height: 50,
      width: 50,
      onPressed: () {
        isPressed = true;
      },
    );
    await tester.pumpWidget(intersection);
    await tester.tap(find.byType(Intersection));
    final stoneFinder = find.byType(Intersection);
    expect(stoneFinder, findsOneWidget);
    await tester.pump();
    expect(isPressed, true);
  });
}
