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
    double? height,
    BoardTheme? theme,
    super.anchor = Anchor.center,
  })  : theme = theme ?? BoardThemes.basic(),
        super(
          size: Vector2(width, height ?? width),
        );

  final int boardSize;
  final BoardTheme theme;

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

  double Function({int? x, int? y}) get lineThickness =>
      ({int? x, int? y}) => theme.lineThickness(this, x: x, y: y);
  double get startPointRadius => theme.startPointRadius(this);
  double get intersectionWidth => theme.intersectionWidth(this);
  double get intersectionHeight => theme.intersectionHeight(this);
  double get stoneRadius => theme.stoneRadius(this);
  bool Function(int x, int y) get isStarPoint =>
      (int x, int y) => theme.isStarPoint(this, x, y);
  BoardAxisLabels get labels => theme.labels;

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
    canvas.drawRect(size.toRect(), theme.paint);

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
            ..strokeWidth = lineThickness(y: i)
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
            ..strokeWidth = lineThickness(x: i)
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
