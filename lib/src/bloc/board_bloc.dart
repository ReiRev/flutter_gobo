import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gobo/src/models/coordinate.dart';

part 'board_state.dart';
part 'input_event.dart';

class BoardBloc extends Bloc<InputEvent, BoardState> {
  BoardBloc() : super(BoardState.initial()) {
    on<TappedDown>(_onTappedDown);
  }

  void _onTappedDown(TappedDown event, Emitter<BoardState> emit) {}
}
