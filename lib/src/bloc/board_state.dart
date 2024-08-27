part of 'board_bloc.dart';

enum BoardActionType { none, add, remove }

class BoardAction extends Equatable {
  const BoardAction({
    required this.actionType,
    required this.coordinate,
    this.stoneOverlay = '',
  });

  final BoardActionType actionType;
  final Coordinate coordinate;
  final String stoneOverlay;

  const BoardAction.initial()
      : actionType = BoardActionType.none,
        coordinate = const Coordinate(0, 0),
        stoneOverlay = '';

  @override
  List<Object> get props => [actionType, coordinate, stoneOverlay];
}

class BoardState extends Equatable {
  const BoardState({
    required final Map<Coordinate, String> stonePositionMap,
    BoardAction? lastBoardAction,
  })  : _stonePositionMap = stonePositionMap,
        _lastBoardAction = lastBoardAction ?? const BoardAction.initial();

  final Map<Coordinate, String> _stonePositionMap;
  final BoardAction _lastBoardAction;

  BoardState.initial()
      : _stonePositionMap = {},
        _lastBoardAction = const BoardAction.initial();

  get stonePositionMap => _stonePositionMap;
  get lastBoardAction => _lastBoardAction;

  // TODO: currently support only linear history, but
  // should support branching history.
  // should add BoardActionType.forceUpdate?
  BoardState copyWith({
    BoardAction? lastBoardAction,
  }) {
    return BoardState(
      stonePositionMap: _stonePositionMap,
      lastBoardAction: lastBoardAction ?? _lastBoardAction,
    );
  }

  @override
  List<Object> get props => [_lastBoardAction];
}
