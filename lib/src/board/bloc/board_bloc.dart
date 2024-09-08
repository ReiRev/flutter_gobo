import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gobo/gobo.dart';

part 'board_state.dart';
part 'input_event.dart';

class BoardBloc extends Bloc<BoardInputEvent, BoardState> {
  BoardBloc({
    required this.stoneOverlayBuilderMap,
  }) : super(BoardState.initial()) {
    on<BoardInputEvent>(onBoardInputEvent);
    on<BoardTappedDownEvent>(onBoardTappedDownEvent);
    on<BoardTappedUpEvent>(onBoardTappedUpEvent);
    on<BoardLongTappedDownEvent>(onBoardLongTappedDownEvent);
    on<BoardDoubleTappedDownEvent>(onBoardDoubleTappedDownEvent);
  }

  final Map<String, StoneComponent Function()> stoneOverlayBuilderMap;

  void putStone(String stoneOverlay, Coordinate at, Emitter<BoardState> emit) {
    emit(state.copyWithStoneAdded(stoneOverlay, at));
  }

  void removeStone(Coordinate at, Emitter<BoardState> emit) {
    emit(state.copyWithStoneRemoved(at));
  }

  void onBoardInputEvent(BoardInputEvent event, Emitter<BoardState> emit) {}

  void onBoardTappedDownEvent(
      BoardTappedDownEvent event, Emitter<BoardState> emit) {}

  void onBoardTappedUpEvent(
      BoardTappedUpEvent event, Emitter<BoardState> emit) {}

  void onBoardLongTappedDownEvent(
      BoardLongTappedDownEvent event, Emitter<BoardState> emit) {}

  void onBoardDoubleTappedDownEvent(
      BoardDoubleTappedDownEvent event, Emitter<BoardState> emit) {}
}
