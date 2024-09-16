import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gobo/gobo.dart';

class Gobo extends StatelessWidget {
  const Gobo({
    super.key,
    required this.board,
  });

  final BoardComponent board;

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: GoboGame(board: board));
  }
}
