import 'package:equatable/equatable.dart';
import 'package:flame/components.dart';

/// Coordinates on the board.
class Coordinate extends Equatable {
  const Coordinate(
    this.x,
    this.y,
  );

  final int x;
  final int y;

  /// Converts the coordinate to a position on the board.
  Vector2 toPosition(double intersectionWidth, double intersectionHeight) {
    return Vector2(
      x * intersectionWidth + intersectionWidth / 2,
      y * intersectionHeight + intersectionHeight / 2,
    );
  }

  @override
  String toString() {
    return 'Coordinate($x, $y)';
  }

  @override
  List<Object> get props => [x, y];
}
