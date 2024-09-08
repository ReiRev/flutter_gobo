part of 'board_bloc.dart';

class BoardInputEvent extends Equatable {
  const BoardInputEvent(
    this.type,
    this.coordinate,
  );

  final Coordinate coordinate;
  final Type type;

  @override
  String toString() {
    return '$type, ($coordinate)';
  }

  @override
  List<Object> get props => [type, coordinate];
}

class BoardTappedEvent extends BoardInputEvent {
  const BoardTappedEvent(Coordinate coordinate)
      : super(BoardTappedEvent, coordinate);

  @override
  String toString() {
    return 'BoardTappedEvent, ($coordinate)';
  }
}

class BoardDoubleTappedEvent extends BoardInputEvent {
  const BoardDoubleTappedEvent(Coordinate coordinate)
      : super(BoardTappedEvent, coordinate);

  @override
  String toString() {
    return 'BoardDoubleTappedEvent, ($coordinate)';
  }
}
