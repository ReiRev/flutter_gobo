import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/painting.dart';
import 'package:gobo/gobo.dart';
import 'package:flame/src/events/messages/position_event.dart';

class BoardComponent extends RectangleComponent
    with TapCallbacks, FlameBlocReader<BoardBloc, BoardState> {
  BoardComponent({
    required super.size,
    super.position,
    this.boardSize = 19,
  })  : lineThickness = size * 0.3 / 140,
        startPointRadius = size * 0.6 / 140,
        intersectionWidth = size / boardSize,
        intersectionHeight = size / boardSize,
        stoneRadius = size * 3.75 / 140,
        super.square(
          anchor: Anchor.center,
        );

  final int boardSize;
  final double lineThickness;
  final double startPointRadius;
  final double intersectionWidth;
  final double intersectionHeight;
  final double stoneRadius;

  bool isStarPoint(int x, int y) {
    return (x == 3 || x == (boardSize / 2).floor() || x == boardSize - 1 - 3) &&
        (y == 3 || y == (boardSize / 2).floor() || y == boardSize - 1 - 3);
  }

  Map<Coordinate, StoneComponent> stones = {};

  void putStone(StoneComponent stone, Coordinate at) {
    if (stones[at] != null) {
      remove(stones[at]!);
      stones.remove(at);
    }
    stones[at] = stone
      ..radius = stoneRadius
      ..position = at.toPosition(intersectionWidth, intersectionHeight)
      ..coordinate = at;
    add(stones[at]!);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await add(FlameBlocListener<BoardBloc, BoardState>(
      onNewState: (BoardState state) {
        switch (state.lastBoardAction.actionType) {
          case BoardActionType.add:
            if (stones[state.lastBoardAction.coordinate] != null) {}
            putStone(
              bloc.stoneOverlayBuilderMap[
                  state.lastBoardAction.stoneOverlay]!(),
              state.lastBoardAction.coordinate,
            );
            break;
          case BoardActionType.remove:
            dynamic stone = stones[state.lastBoardAction.coordinate];
            if (stone != null) {
              remove(stone);
            }
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
            ..strokeWidth = lineThickness,
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
            ..strokeWidth = lineThickness,
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

  void addBoardInputEvent(PositionEvent event) {
    bloc.add(BoardInputEvent(
      event.runtimeType,
      Coordinate(
        (event.localPosition.x / intersectionWidth).floor(),
        (event.localPosition.y / intersectionHeight).floor(),
      ),
    ));
  }

  @override
  void onTapDown(TapDownEvent event) {
    addBoardInputEvent(event);
  }
}
