part of 'board_bloc.dart';

abstract class InputEvent extends Equatable {
  const InputEvent(
    this.coordinate,
  );

  final Coordinate coordinate;

  @override
  List<Object> get props => [coordinate];
}

class TappedDown extends InputEvent {
  const TappedDown(
    super.coordinate,
  );
}
