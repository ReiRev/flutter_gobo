import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/painting.dart';
import 'package:gobo/gobo.dart';

class BoardComponent extends RectangleComponent
    with
        TapCallbacks,
        DoubleTapCallbacks,
        FlameBlocReader<BoardBloc, BoardState> {
  BoardComponent({
    this.boardSize = 19,
    required double width,
    required double height,
    BoardStyle? style,
    super.anchor = Anchor.center,
  })  : style = style ?? BoardStyles.basic(),
        super(
          size: Vector2(width, height),
        );

  final int boardSize;
  final BoardStyle style;

  @override
  double get width => size.x;

  @override
  set width(double width) {
    size = Vector2(width, height);
  }

  @override
  double get height => size.y;

  @override
  set height(double height) {
    size = Vector2(size.x, height);
  }

  double get lineThickness => style.lineThickness(this);
  double get startPointRadius => style.startPointRadius(this);
  double get intersectionWidth => style.intersectionWidth(this);
  double get intersectionHeight => style.intersectionHeight(this);
  double get stoneRadius => style.stoneRadius(this);
  BoardAxisLabels get labels => style.labels;

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
    for (final component in labels.createAxisLabels(
      boardSize,
      intersectionWidth,
      intersectionHeight,
    )) {
      await add(component);
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
            if (style.isStarPoint(this, x, y))
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
