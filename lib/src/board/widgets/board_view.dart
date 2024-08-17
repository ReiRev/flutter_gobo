import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gobo/gobo.dart';

class BoardView extends StatelessWidget {
  const BoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BoardBloc, IntersectionTable>(
      builder: (context, stoneTable) {
        return Container(
          color: BoardConfig.of(context).theme.boardColor,
          width: BoardConfig.of(context).dimension.width,
          height: BoardConfig.of(context).dimension.width,
          child: GridView.count(
            crossAxisCount: BoardConfig.of(context).dimension.size,
            children: stoneTable.withCallback(context).transpose().flatten(),
          ),
        );
      },
    );
  }
}