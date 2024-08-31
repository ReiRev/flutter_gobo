import 'package:flame/game.dart';
import 'package:gobo/gobo.dart';
import 'package:gobo/src/board/board.dart';
import 'package:flame_bloc/flame_bloc.dart';

class GoboGame extends FlameGame {
  GoboGame({
    required this.board,
    required this.boardBloc,
    super.world,
    super.camera,
  });

  final BoardComponent board;
  final BoardBloc boardBloc;

  @override
  Future<void> onLoad() async {
    world.add(
      FlameBlocProvider<BoardBloc, BoardState>.value(
        value: boardBloc,
        children: [board],
      ),
    );
    camera.follow(board);
  }
}
