export 'stone_component.dart';

import './stone_component.dart';
import 'stone_painters.dart';

abstract final class Stones {
  /// A stone that is invisible.
  static var invisible = ({double? radius}) =>
      StoneComponent(paintLayers: [StonePainters.invisible()], radius: radius);

  /// A simple black stone.
  static var black = () => StoneComponent(
        paintLayers: [StonePainters.black()],
      );

  /// A simple white stone.
  static var white = ({double? radius}) => StoneComponent(
        paintLayers: StonePainters.white(),
        radius: radius,
      );

  /// A stone used in Wikipedia.
  static var wikipediaBlack = () => StoneComponent(
        paintLayers: [StonePainters.wikipediaBlack()],
      );

  /// A stone used in Wikipedia.
  static var wikipediaWhite = () => StoneComponent(
        paintLayers: [StonePainters.wikipediaWhite()],
      );
}
