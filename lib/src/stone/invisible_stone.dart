import 'paints/stone_paints.dart';

import 'stone_component.dart';

class InvisibleStone extends StoneComponent {
  InvisibleStone({
    super.radius,
  }) : super(painter: StonePainters.invisible);
}
