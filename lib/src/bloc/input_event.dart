part of 'board_bloc.dart';

class InputEvent extends Equatable {
  const InputEvent(
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
