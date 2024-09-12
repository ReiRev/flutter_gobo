import 'package:gobo/gobo.dart';

export 'stone_component.dart';
export 'invisible_stone.dart';
export 'wikipedia/wikipedia.dart';
export 'paints/stone_paints.dart';

abstract final class Stones {
  static StoneComponent invisible = InvisibleStone();
  static StoneComponent wikipediaBlack = WikipediaBlackStone();
  static StoneComponent wikipediaWhite = WikipediaWhiteStone();
}
