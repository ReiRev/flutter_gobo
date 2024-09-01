import '../stone_component.dart';
import '../paints/stone_paints.dart';

class WikipediaWhiteStone extends StoneComponent {
  WikipediaWhiteStone({
    super.radius,
  }) : super(painter: StonePainters.wikipediaWhite);
}
