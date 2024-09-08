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

class BoardTappedDownEvent extends BoardInputEvent {
  const BoardTappedDownEvent(Coordinate coordinate)
      : super(BoardTappedDownEvent, coordinate);

  @override
  String toString() {
    return 'BoardTappedDownEvent, ($coordinate)';
  }
}

class BoardTappedUpEvent extends BoardInputEvent {
  const BoardTappedUpEvent(Coordinate coordinate)
      : super(BoardTappedUpEvent, coordinate);

  @override
  String toString() {
    return 'BoardTappedUpEvent, ($coordinate)';
  }
}

class BoardDoubleTappedDownEvent extends BoardInputEvent {
  const BoardDoubleTappedDownEvent(Coordinate coordinate)
      : super(BoardDoubleTappedDownEvent, coordinate);

  @override
  String toString() {
    return 'BoardDoubleTappedDownEvent, ($coordinate)';
  }
}

class BoardLongTappedDownEvent extends BoardInputEvent {
  const BoardLongTappedDownEvent(Coordinate coordinate)
      : super(BoardLongTappedDownEvent, coordinate);

  @override
  String toString() {
    return 'BoardLongTappedDownEvent, ($coordinate)';
  }
}
