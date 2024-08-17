import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gobo/gobo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'board_event.dart';
part 'intersection_table.dart';

typedef BoardStateHandler<EventType> = void Function(
  EventType event,
  Emitter<IntersectionTable> emit,
  IntersectionTable state,
);

class BoardBloc extends Bloc<BoardEvent, IntersectionTable> {
  BoardBloc({
    required this.boardSize,
    IntersectionTable? initialTable,
    // void Function(StoneHovered event, Emitter<IntersectionTable> emit)?
    //     onStoneHovered,
    // void Function(StonePressed event, Emitter<IntersectionTable> emit)?
    //     onStonePressed,
    // void Function(StoneDoublePressed event, Emitter<IntersectionTable> emit)?
    //     onStoneDoublePressed,
    BoardStateHandler<StoneHovered>? onStoneHovered,
    BoardStateHandler<StonePressed>? onStonePressed,
    BoardStateHandler<StoneDoublePressed>? onStoneDoublePressed,
  })  : onStoneHovered = onStoneHovered ?? ((_, __, ___) {}),
        onStonePressed = onStonePressed ?? ((_, __, ___) {}),
        onStoneDoublePressed = onStoneDoublePressed ?? ((_, __, ___) {}),
        super(IntersectionTable(boardSize: boardSize)) {
    on<StoneHovered>((event, emit) {
      // this.onStoneHovered(event, emit);
      // emit(state.updateStone(event.x, event.y, const WhiteStone()));
      this.onStoneHovered(event, emit, state);
    });
    // on<StonePressed>(this.onStonePressed);
    on<StonePressed>((event, emit) {
      // emit(state.added(event.x, event.y, const BlackStone()));
      this.onStonePressed(event, emit, state);
    });
    // on<StoneDoublePressed>(this.onStoneDoublePressed);
    on<StoneDoublePressed>((event, emit) {
      // emit(state.added(event.x, event.y, const EmptyStone()));
      this.onStoneDoublePressed(event, emit, state);
    });
  }

  final int boardSize;
  // final void Function(StoneHovered event, Emitter<IntersectionTable> emit)
  //     onStoneHovered;
  // final void Function(StonePressed event, Emitter<IntersectionTable> emit)
  //     onStonePressed;
  // final void Function(StoneDoublePressed event, Emitter<IntersectionTable> emit)
  //     onStoneDoublePressed;
  final BoardStateHandler<StoneHovered> onStoneHovered;
  final BoardStateHandler<StonePressed> onStonePressed;
  final BoardStateHandler<StoneDoublePressed> onStoneDoublePressed;
}
