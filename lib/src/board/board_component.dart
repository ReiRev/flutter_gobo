import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import 'package:gobo/gobo.dart';

const double referenceBoardWidth = 500;
const double referenceBoardHeight = 500;

/// A component that represents a Go board.
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

  /// The size of the board. ex. 19
  final int boardSize;

  /// The theme of the board represented as [BoardTheme].
  final BoardTheme theme;

  /// The width of the board.
  @override
  double get width => size.x;

  @override
  set width(double width) {
    size = Vector2(width, height);
  }

  /// The height of the board.
  @override
  double get height => size.y;

  @override
  set height(double height) {
    size = Vector2(size.x, height);
  }

  /// The thickness of the lines on the board.
  double Function({int? x, int? y}) get lineThickness =>
      ({int? x, int? y}) => theme.lineThickness(this, x: x, y: y);

  /// The radius of the start point.
  double get startPointRadius => theme.startPointRadius(this);

  /// The width of the intersection line.
  double get intersectionWidth => theme.intersectionWidth(this);

  /// The height of the intersection line.
  double get intersectionHeight => theme.intersectionHeight(this);

  /// The radius of the stone.
  double get stoneRadius => theme.stoneRadius(this);

  /// A function that returns true if the given coordinate is a star point.
  bool Function(int x, int y) get isStarPoint =>
      (int x, int y) => theme.isStarPoint(this, x, y);

  /// The labels of the board.
  BoardAxisLabels get labels => theme.labels;

  final Map<Coordinate, StoneComponent> _stones = {};

  /// The stones on the board.
  Map<Coordinate, StoneComponent> get stones => _stones;

  /// Places a stone on the board at the given coordinate.
  void putStone(StoneComponent stone, Coordinate at) {
    if (_stones[at] != null) {
      remove(_stones[at]!);
      _stones.remove(at);
    }
    _stones[at] = stone
      ..radius = stoneRadius
      ..position = at.toPosition(intersectionWidth, intersectionHeight);
    add(_stones[at]!);
  }

  /// Removes a stone from the board at the given coordinate.
  void removeStone(Coordinate at) {
    if (_stones[at] != null) {
      remove(_stones[at]!);
      _stones.remove(at);
    }
  }

  Future<void> _addAxisLabels() async {
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

    _addAxisLabels();
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

  /// Converts an event position to a coordinate on the board.
  Coordinate eventPositionToCoordinate(Vector2 eventPosition) {
    return Coordinate(
      (eventPosition.x / intersectionWidth).floor(),
      (eventPosition.y / intersectionHeight).floor(),
    );
  }
}
