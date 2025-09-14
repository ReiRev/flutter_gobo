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
import 'dart:async';
import 'dart:js_interop';
import 'dart:js_util' as js_util;
import 'package:web/web.dart' as web;

// Web-only helpers for downloading and picking text files (SGF).
bool saveTextFile(String filename, String text) {
  final parts = (<web.BlobPart>[text.toJS]).toJS;
  final blob = web.Blob(parts);
  final url = web.URL.createObjectURL(blob);
  final anchor = web.HTMLAnchorElement()
    ..href = url
    ..download = filename
    ..style.display = 'none';
  web.document.body?.append(anchor);
  anchor.click();
  anchor.remove();
  web.URL.revokeObjectURL(url);
  return true;
}

Future<String?> pickTextFile({String accept = '.sgf,application/x-go-sgf,text/plain'}) async {
  final input = web.HTMLInputElement()
    ..type = 'file'
    ..accept = accept
    ..multiple = false
    ..style.display = 'none';
  web.document.body?.append(input);

  final completer = Completer<String?>();
  void cleanup() => input.remove();

  input.addEventListener(
    'change',
    ((web.Event _) {
      final files = input.files;
      final file = (files != null && files.length > 0) ? files.item(0) : null;
      if (file == null) {
        cleanup();
        completer.complete(null);
        return;
      }
      js_util.promiseToFuture<String>(file.text()).then((value) {
        cleanup();
        completer.complete(value);
      }).catchError((_) {
        cleanup();
        completer.complete(null);
      });
    }).toJS,
  );

  input.click();
  return completer.future;
}

abstract class BoardEvent extends Equatable {
  const BoardEvent();
}

class BoardCoordinatePressed extends BoardEvent {
  final Coordinate coordinate;

  const BoardCoordinatePressed(this.coordinate);

  @override
  List<Object?> get props => [coordinate.x, coordinate.y];
}

class BoardPassPressed extends BoardEvent {
  const BoardPassPressed();

  @override
  List<Object?> get props => const [];
}

class BoardUndoPressed extends BoardEvent {
  const BoardUndoPressed();

  @override
  List<Object?> get props => const [];
}

class BoardImportSgf extends BoardEvent {
  final String sgf;
  const BoardImportSgf(this.sgf);

  @override
  List<Object?> get props => [sgf];
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
    _game.application = "GOLO Example Game Editor";
    on<BoardCoordinatePressed>((BoardCoordinatePressed e, emit) {
      try {
        _game.play((x: e.coordinate.x, y: e.coordinate.y));
        emit(BoardState(_game.board));
      } catch (e) {
        print(e);
      }
    });
    on<BoardImportSgf>((e, emit) {
      try {
        _game = golo.Game.fromSgf(e.sgf);
        _game.application = "GOLO Example Game Editor";
        emit(BoardState(_game.board));
      } catch (err) {
        // ignore: avoid_print
        print('Failed to import SGF: $err');
      }
    });
    on<BoardPassPressed>((e, emit) {
      _game.pass();
      emit(BoardState(_game.board));
    });
    on<BoardUndoPressed>((e, emit) {
      final b = _game.undo();
      if (b != null) {
        emit(BoardState(b));
      }
    });
  }
  golo.Game _game;
  bool get canUndo => _game.canUndo;
  String toSgf() => _game.toSgf();
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

class InfoBar extends StatelessWidget {
  const InfoBar({
    super.key,
    this.height = 44,
    this.backgroundColor = const Color(0xFF9F8109),
  });

  final double height;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: BlocBuilder<BoardBloc, BoardState>(
        builder: (context, state) {
          final int blackCaptures = state.board.getCaptures(golo.Stone.black);
          final int whiteCaptures = state.board.getCaptures(golo.Stone.white);
          return DefaultTextStyle.merge(
              style: const TextStyle(color: Colors.white),
              child: Row(
                children: [
                  // Black
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text('$blackCaptures'),
                  const SizedBox(width: 16),
                  // White (show with border to be visible on light bg)
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.black54, width: 1),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text('$whiteCaptures'),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () async {
                      final text = await pickTextFile(
                          accept: '.sgf,application/x-go-sgf,text/plain');
                      if (text == null) {
                        print("Failed to load SGF");
                        return;
                      }
                      context.read<BoardBloc>().add(BoardImportSgf(text));
                    },
                    icon: const Icon(Icons.upload_file, color: Colors.white),
                    label: const Text(
                      'fromSGF',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 4),
                  TextButton.icon(
                    onPressed: context.read<BoardBloc>().canUndo
                        ? () => context
                            .read<BoardBloc>()
                            .add(const BoardUndoPressed())
                        : null,
                    icon: const Icon(Icons.undo, color: Colors.white),
                    label: const Text(
                      'undo',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 4),
                  TextButton.icon(
                    onPressed: () =>
                        context.read<BoardBloc>().add(const BoardPassPressed()),
                    icon: const Icon(Icons.flag_outlined, color: Colors.white),
                    label: const Text(
                      'pass',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 4),
                  TextButton.icon(
                    onPressed: () {
                      final sgf = context.read<BoardBloc>().toSgf();
                      final now = DateTime.now();
                      String two(int n) => n.toString().padLeft(2, '0');
                      final ts =
                          '${now.year}${two(now.month)}${two(now.day)}-${two(now.hour)}${two(now.minute)}${two(now.second)}';
                      final filename = 'golo-$ts.sgf';
                      saveTextFile(filename, sgf);
                    },
                    icon: const Icon(Icons.download, color: Colors.white),
                    label: const Text(
                      'toSGF',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}

class GameEditorWrapper extends StatelessWidget {
  const GameEditorWrapper(
      {super.key,
      required this.width,
      required this.height,
      required this.infoBarHeight,
      required this.boardSize});

  final double width;
  final double height;
  final double infoBarHeight;
  final int boardSize;

  @override
  Widget build(BuildContext context) {
    final bloc = BoardBloc(boardSize: boardSize);
    final board = Board(
      width: width,
      height: height,
      boardSize: boardSize,
    );
    return BlocProvider.value(
      value: bloc,
      child: SizedBox(
        width: width,
        height: height + infoBarHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top settings bar (separated widget)
            InfoBar(
              height: infoBarHeight,
            ),
            // The game takes the remaining space
            Expanded(
              child: ClipRect(
                child: GameWidget(
                  game: GameEditor(bloc: bloc, board: board),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

@widgetbook.UseCase(name: 'Game Editor', type: FlameGame)
Widget buildGameEditor(BuildContext context) {
  final w = context.knobs.double
      .slider(label: 'width', initialValue: 500, min: 100, max: 1200);
  final h = context.knobs.double
      .slider(label: 'height', initialValue: 500, min: 100, max: 1200);
  final infoBarHeight = context.knobs.double
      .slider(label: 'info bar height', initialValue: 50, min: 5, max: 100);
  final size = context.knobs.int
      .slider(label: 'board size', initialValue: 19, min: 5, max: 25);

  return Center(
      child: GameEditorWrapper(
    width: w,
    height: h,
    infoBarHeight: infoBarHeight,
    boardSize: size,
  ));
}
