import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/painting.dart';
import 'package:gobo/gobo.dart';
import 'package:gobo/src/board/board_labels.dart';

class BoardComponent extends RectangleComponent
    with
        TapCallbacks,
        DoubleTapCallbacks,
        FlameBlocReader<BoardBloc, BoardState> {
  BoardComponent({
    required super.size,
    super.position,
    this.boardSize = 19,
    BoardAxesLabels? labels,
  })  : lineThickness = size * 0.3 / 140 * 19 / boardSize,
        startPointRadius = size * 0.6 / 140 * 19 / boardSize,
        intersectionHeight = size / boardSize,
        intersectionWidth = size / boardSize,
        stoneRadius = size * 3.75 / 140 * 19 / boardSize,
        labels = labels ?? BoardAxesLabels.none(),
        super.square(
          anchor: Anchor.center,
        );

  final int boardSize;
  final double lineThickness;
  final double startPointRadius;
  final double intersectionWidth;
  final double intersectionHeight;
  late final double stoneRadius;
  final BoardAxesLabels labels;

  bool isStarPoint(int x, int y) {
    List<int> lineIndices =
        boardSize >= 13 ? [3, boardSize - 4] : [2, boardSize - 3];
    if (boardSize % 2 == 1) {
      lineIndices.add((boardSize / 2).floor());
    }
    if (lineIndices.contains(x) && lineIndices.contains(y)) {
      return true;
    }
    return false;
  }

  Map<Coordinate, StoneComponent> stones = {};

  void putStone(StoneComponent stone, Coordinate at) {
    if (stones[at] != null) {
      remove(stones[at]!);
      stones.remove(at);
    }
    stones[at] = stone
      ..radius = stoneRadius
      ..position = at.toPosition(intersectionWidth, intersectionHeight);
    add(stones[at]!);
  }

  void removeStone(Coordinate at) {
    if (stones[at] != null) {
      remove(stones[at]!);
      stones.remove(at);
    }
  }

  Future<void> addAxisLabels() async {
    for (int i = 0; i < boardSize; i++) {
      if (labels.top != null) {
        await add(
          TextComponent(
            position: Vector2(
              intersectionWidth * (i + 0.5),
              -intersectionHeight * 0.5,
            ),
            size: Vector2(intersectionWidth, intersectionHeight),
            text: labels.top?.indexToLabel(i),
            anchor: Anchor.center,
            textRenderer: labels.top?.textRenderer(
              intersectionWidth,
              intersectionHeight,
            ),
          ),
        );
      }

      if (labels.bottom != null) {
        await add(
          TextComponent(
            position: Vector2(
              intersectionWidth * (i + 0.5),
              size.y + intersectionHeight * 0.5,
            ),
            size: Vector2(intersectionWidth, intersectionHeight),
            text: labels.bottom?.indexToLabel(i),
            anchor: Anchor.center,
            textRenderer: labels.bottom?.textRenderer(
              intersectionWidth,
              intersectionHeight,
            ),
          ),
        );
      }

      if (labels.left != null) {
        await add(
          TextComponent(
            position: Vector2(
              -intersectionWidth * 0.5,
              intersectionHeight * (i + 0.5),
            ),
            size: Vector2(intersectionWidth, intersectionHeight),
            text: labels.left?.indexToLabel(i),
            anchor: Anchor.center,
            textRenderer: labels.left?.textRenderer(
              intersectionWidth,
              intersectionHeight,
            ),
          ),
        );
      }

      if (labels.right != null) {
        await add(
          TextComponent(
            position: Vector2(
              size.x + intersectionWidth * 0.5,
              intersectionHeight * (i + 0.5),
            ),
            size: Vector2(intersectionWidth, intersectionHeight),
            text: labels.right?.indexToLabel(i),
            anchor: Anchor.center,
            textRenderer: labels.right?.textRenderer(
              intersectionWidth,
              intersectionHeight,
            ),
          ),
        );
      }
    }
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // await addAxisLabels();
    addAxisLabels();

    await add(FlameBlocListener<BoardBloc, BoardState>(
      onInitialState: (BoardState state) {
        state.stonePositionMap.forEach((coordinate, stoneOverlay) {
          putStone(
            bloc.stoneOverlayBuilderMap[stoneOverlay]!(),
            coordinate,
          );
        });
      },
      onNewState: (BoardState state) {
        switch (state.lastBoardAction.actionType) {
          case BoardActionType.add:
            removeStone(state.lastBoardAction.coordinate);
            putStone(
              bloc.stoneOverlayBuilderMap[
                  state.lastBoardAction.stoneOverlay]!(),
              state.lastBoardAction.coordinate,
            );
            break;
          case BoardActionType.remove:
            removeStone(state.lastBoardAction.coordinate);
            break;
          default:
            break;
        }
      },
    ));
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(
      size.toRect(),
      Paint()..color = const Color.fromRGBO(214, 181, 105, 1),
    );

    // draw horizontal lines
    List.generate(
      boardSize,
      (i) => {
        canvas.drawLine(
          Offset(intersectionWidth / 2,
              i * intersectionHeight + intersectionHeight / 2),
          Offset(size.x - intersectionWidth / 2,
              i * intersectionHeight + intersectionHeight / 2),
          Paint()
            ..color = const Color.fromRGBO(0, 0, 0, 1)
            ..strokeWidth = lineThickness
            ..strokeCap = StrokeCap.square,
        )
      },
    );

    // draw vertical lines
    List.generate(
      boardSize,
      (i) => {
        canvas.drawLine(
          Offset(i * intersectionWidth + intersectionWidth / 2,
              intersectionHeight / 2),
          Offset(i * intersectionWidth + intersectionWidth / 2,
              size.y - intersectionHeight / 2),
          Paint()
            ..color = const Color.fromRGBO(0, 0, 0, 1)
            ..strokeWidth = lineThickness
            ..strokeCap = StrokeCap.square,
        )
      },
    );

    // draw star points
    List.generate(
      boardSize,
      (x) => {
        List.generate(
          boardSize,
          (y) => {
            if (isStarPoint(x, y))
              {
                canvas.drawCircle(
                  Offset(x * intersectionWidth + intersectionWidth / 2,
                      y * intersectionHeight + intersectionHeight / 2),
                  startPointRadius,
                  Paint()..color = const Color.fromRGBO(0, 0, 0, 1),
                )
              }
          },
        )
      },
    );
  }

  // write func to convert the event position to the coordinate on the board
  Coordinate eventPositionToCoordinate(Vector2 eventPosition) {
    return Coordinate(
      (eventPosition.x / intersectionWidth).floor(),
      (eventPosition.y / intersectionHeight).floor(),
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    bloc.add(BoardTappedDownEvent(
      eventPositionToCoordinate(event.localPosition),
    ));
  }

  @override
  void onTapUp(TapUpEvent event) {
    bloc.add(BoardTappedUpEvent(
      eventPositionToCoordinate(event.localPosition),
    ));
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    bloc.add(BoardLongTappedDownEvent(
      eventPositionToCoordinate(event.localPosition),
    ));
  }

  @override
  void onDoubleTapDown(DoubleTapDownEvent event) {
    bloc.add(BoardDoubleTappedDownEvent(
      eventPositionToCoordinate(event.localPosition),
    ));
  }
}
