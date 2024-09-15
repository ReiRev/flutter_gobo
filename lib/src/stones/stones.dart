export 'stone_component.dart';
export 'stone_paints.dart';

import 'package:gobo/gobo.dart';

abstract final class Stones {
  static var invisible = ({double? radius}) =>
      StoneComponent(paintLayers: [StonePainters.invisible()], radius: radius);
  static var black = () => StoneComponent(
        paintLayers: [StonePainters.black()],
      );
  static var white = ({double? radius}) => StoneComponent(
        paintLayers: StonePainters.white(),
        radius: radius,
      );
  static var wikipediaBlack = () => StoneComponent(
        paintLayers: [StonePainters.wikipediaBlack()],
      );
  static var wikipediaWhite = () => StoneComponent(
        paintLayers: [StonePainters.wikipediaWhite()],
      );
}
