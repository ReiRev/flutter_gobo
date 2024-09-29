import 'package:flame/game.dart';
import 'package:gobo/gobo.dart';
import 'package:gobo/src/board/board.dart';

/// A game that displays a [BoardComponent].
class GoboGame extends FlameGame {
  GoboGame({
    required this.board,
    super.world,
    super.camera,
  });

  final BoardComponent board;

  @override
  Future<void> onLoad() async {
    world.add(board);
    camera.follow(board);
  }
}
