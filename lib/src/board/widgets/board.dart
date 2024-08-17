import 'package:flutter/material.dart';
import 'package:gobo/gobo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Board extends StatelessWidget {
  const Board({
    super.key,
    required this.dimension,
    required this.theme,
    this.initialStoneTable,
    this.onStoneHovered,
    this.onStonePressed,
    this.onStoneDoublePressed,
  });

  final BoardDimension dimension;
  final BoardTheme theme;
  final IntersectionTable? initialStoneTable;
  // final void Function(StoneHovered event, Emitter<IntersectionTable> emit)?
  //     onStoneHovered;
  // final void Function(StonePressed event, Emitter<IntersectionTable> emit)?
  //     onStonePressed;
  // final void Function(
  //         StoneDoublePressed event, Emitter<IntersectionTable> emit)?
  //     onStoneDoublePressed;
  final BoardStateHandler<StoneHovered>? onStoneHovered;
  final BoardStateHandler<StonePressed>? onStonePressed;
  final BoardStateHandler<StoneDoublePressed>? onStoneDoublePressed;

  @override
  Widget build(BuildContext context) {
    return BoardConfigProvider(
      dimension: dimension,
      theme: theme,
      child: BlocProvider(
        create: (context) => BoardBloc(
          boardSize: dimension.size,
          initialTable: initialStoneTable,
          onStoneHovered: onStoneHovered,
          onStonePressed: onStonePressed,
          onStoneDoublePressed: onStoneDoublePressed,
        ),
        child: const BoardView(),
      ),
    );
  }
}
