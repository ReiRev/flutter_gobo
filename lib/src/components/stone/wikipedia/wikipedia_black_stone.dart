import '../stone_component.dart';
import '../../../paints/stone_paints.dart';

class WikipediaBlackStone extends StoneComponent {
  WikipediaBlackStone({
    super.radius,
  }) : super(painter: StonePainters.wikipediaBlack);
}
