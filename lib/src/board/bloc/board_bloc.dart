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
  }

  final Map<String, StoneComponent Function()> stoneOverlayBuilderMap;

  void putStone(String stoneOverlay, Coordinate at, Emitter<BoardState> emit) {
    emit(state.copyWithStoneAdded(stoneOverlay, at));
  }

  void removeStone(Coordinate at, Emitter<BoardState> emit) {
    emit(state.copyWithStoneRemoved(at));
  }

  void onBoardInputEvent(BoardInputEvent event, Emitter<BoardState> emit) {}
}
