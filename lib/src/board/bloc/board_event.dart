part of 'board_bloc.dart';

abstract class BoardEvent extends Equatable {
  const BoardEvent();
}

abstract class StoneInteractionEvent extends BoardEvent {
  const StoneInteractionEvent(this.x, this.y);
  final int x;
  final int y;

  @override
  List<Object> get props => [x, y];
}

class StoneHovered extends StoneInteractionEvent {
  const StoneHovered(super.x, super.y);
}

class StonePressed extends StoneInteractionEvent {
  const StonePressed(super.x, super.y);
}

class StoneDoublePressed extends StoneInteractionEvent {
  const StoneDoublePressed(super.x, super.y);
}
