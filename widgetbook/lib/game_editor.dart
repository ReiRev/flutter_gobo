import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:gobo/gobo.dart';
import 'package:golo/golo.dart' as golo;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class BoardEvent extends Equatable {
  const BoardEvent();
}

class BoardCoordinatePressed extends BoardEvent {
  final Coordinate coordinate;

  const BoardCoordinatePressed(this.coordinate);

  @override
  List<Object?> get props => [coordinate.x, coordinate.y];
}

class BoardState extends Equatable {
  final golo.Board board;

  const BoardState(this.board);

  @override
  List<Object?> get props => [
        board.toString(),
        board.getCaptures(golo.Stone.black),
        board.getCaptures(golo.Stone.white),
      ];
}

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  BoardBloc({required int boardSize})
      : _game = golo.Game(width: boardSize),
        super(BoardState(golo.Game(width: boardSize).board)) {
    on<BoardCoordinatePressed>((BoardCoordinatePressed e, emit) {
      try {
        _game.play((x: e.coordinate.x, y: e.coordinate.y));
        emit(BoardState(_game.board));
      } catch (e) {
        print(e);
      }
    });
    // Emit snapshot from _game to avoid depending on the temp Game in super
  }
  golo.Game _game;
}

class Board extends BoardComponent
    with
        TapCallbacks,
        FlameBlocReader<BoardBloc, BoardState>,
        FlameBlocListenable<BoardBloc, BoardState> {
  Board({
    super.width,
    super.height,
    super.boardSize,
    super.theme,
  });

  StoneComponent get blackStone => Stones.wikipediaBlack();
  StoneComponent get whiteStone => Stones.wikipediaWhite();

  void _syncFromBoard(golo.Board b) {
    final Map<Coordinate, golo.Stone> target = {};
    for (var y = 0; y < b.height; y++) {
      for (var x = 0; x < b.width; x++) {
        final s = b.state[y][x];
        if (s != null) target[Coordinate(x, y)] = s;
      }
    }
    for (final c in List<Coordinate>.from(stones.keys)) {
      if (!target.containsKey(c)) removeStone(c);
    }
    for (final entry in target.entries) {
      final coord = entry.key;
      final color = entry.value;
      if (stones[coord] != null) removeStone(coord);
      putStone(color == golo.Stone.black ? blackStone : whiteStone, coord);
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    final coordinate = eventPositionToCoordinate(event.localPosition);
    bloc.add(BoardCoordinatePressed(coordinate));
  }

  /// Incrementally update stones based on differences between boards.
  void _applyDiff(golo.Board previous, golo.Board next) {
    final diffs = previous.diff(next);
    if (diffs == null) {
      // Fallback to full sync if sizes differ
      _syncFromBoard(next);
      return;
    }

    for (final v in diffs) {
      final coord = Coordinate(v.x, v.y);
      final s = next.get((x: v.x, y: v.y));
      if (stones[coord] != null) {
        removeStone(coord);
      }
      if (s != null) {
        putStone(s == golo.Stone.black ? blackStone : whiteStone, coord);
      }
    }
  }

  golo.Board? _lastBoard;

  @override
  void onInitialState(BoardState state) {
    _syncFromBoard(state.board);
    _lastBoard = state.board;
  }

  @override
  bool listenWhen(BoardState previousState, BoardState newState) {
    final diff = previousState.board.diff(newState.board);
    return diff == null || diff.isNotEmpty;
  }

  @override
  void onNewState(BoardState state) {
    final prev = _lastBoard;
    if (prev == null) {
      _syncFromBoard(state.board);
    } else {
      _applyDiff(prev, state.board);
    }
    _lastBoard = state.board;
  }
}

class GameEditor extends FlameGame {
  GameEditor({required this.bloc, required this.board});

  final BoardBloc bloc;
  final Board board;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final provider = FlameBlocProvider<BoardBloc, BoardState>.value(
      value: bloc,
      children: [board],
    );
    world.add(provider);
    camera.follow(board);
  }
}

class GameEditorWrapper extends StatelessWidget {
  const GameEditorWrapper(
      {super.key,
      required this.width,
      required this.height,
      required this.boardSize});

  final double width;
  final double height;
  final int boardSize;

  @override
  Widget build(BuildContext context) {
    final bloc = BoardBloc(boardSize: boardSize);
    final board = Board(width: width, height: height, boardSize: boardSize);
    return GameWidget(game: GameEditor(bloc: bloc, board: board));
  }
}

@widgetbook.UseCase(name: 'Game Editor', type: FlameGame)
Widget buildGameEditor(BuildContext context) {
  final w = context.knobs.double
      .slider(label: 'width', initialValue: 500, min: 100, max: 1200);
  final h = context.knobs.double
      .slider(label: 'height', initialValue: 500, min: 100, max: 1200);
  final size = context.knobs.int
      .slider(label: 'board size', initialValue: 19, min: 5, max: 25);

  return Center(child: GameEditorWrapper(width: w, height: h, boardSize: size));
}
