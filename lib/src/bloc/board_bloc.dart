import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gobo/src/models/coordinate.dart';
import 'package:flame/components.dart';
import 'package:flame/src/events/messages/position_event.dart';
import 'package:flame/src/game/game.dart';

part 'board_state.dart';
part 'input_event.dart';

class BoardBloc extends Bloc<InputEvent, BoardState> {
  BoardBloc() : super(BoardState.initial()) {
    on<InputEvent>(_onInputEvent);
  }

  // String stoneOverlay
  // Map<String, PositionComponent Function()> stoneOverlayBuilderMap
  // use stoneOverlayBuilderMap to add stone

  void _onInputEvent(InputEvent event, Emitter<BoardState> emit) {
    emit(state.copyWith(
      lastBoardAction: BoardAction(
        actionType: BoardActionType.add,
        coordinate: event.coordinate,
      ),
    ));
  }
}
