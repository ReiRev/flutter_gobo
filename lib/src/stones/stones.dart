export 'stone_component.dart';
export 'stone_paints.dart';

import 'package:gobo/gobo.dart';

abstract final class Stones {
  static var invisible = () => StoneComponent(
        painter: StonePainters.invisible,
      );
  static var black = () => StoneComponent(
        painter: StonePainters.black,
      );
  static var white = () => StoneComponent(
        painter: StonePainters.white,
      );
  static var wikipediaBlack = () => StoneComponent(
        painter: StonePainters.wikipediaBlack,
      );
  static var wikipediaWhite = () => StoneComponent(
        painter: StonePainters.wikipediaWhite,
      );
}
