part of 'board_bloc.dart';

enum BoardElement {
  empty,
  black,
  white,
}

class BoardState extends Equatable {
  const BoardState({
    required this.map,
  });

  final Map<Coordinate, BoardElement> map;

  BoardState.initial() : map = <Coordinate, BoardElement>{};

  @override
  List<Object> get props => [map];
}
