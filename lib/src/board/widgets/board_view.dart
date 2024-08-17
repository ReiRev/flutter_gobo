import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gobo/gobo.dart';

class BoardView extends StatelessWidget {
  const BoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BoardBloc, IntersectionTable>(
      builder: (context, stoneTable) {
        return SizedBox.fromSize(
          size: Size(
            BoardConfig.of(context).dimension.width,
            BoardConfig.of(context).dimension.height,
          ),
          child: Container(
            color: BoardConfig.of(context).theme.boardColor,
            child: GridView.count(
              crossAxisCount: BoardConfig.of(context).dimension.size,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              children: stoneTable.withCallback(context).transpose().flatten(),
            ),
          ),
        );
      },
    );
  }
}
