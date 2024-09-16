import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import 'package:gobo/gobo.dart';

const double referenceBoardWidth = 500;
const double referenceBoardHeight = 500;

class BoardComponent extends RectangleComponent {
  BoardComponent({
    this.boardSize = 19,
    double? width,
    double? height,
    BoardTheme? theme,
    super.anchor = Anchor.center,
  })  : theme = theme ?? BoardThemes.basic(),
        super(
          size: Vector2(referenceBoardHeight, referenceBoardWidth),
          scale: Vector2(
            width == null ? 1 : width / referenceBoardWidth,
            height == null ? 1 : height / referenceBoardHeight,
          ),
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
  set size(Vector2 size) {
    scale =
        Vector2(size.x / referenceBoardWidth, size.y / referenceBoardHeight);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    addAxisLabels();
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
}
