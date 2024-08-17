part of 'board_bloc.dart';

class IntersectionTable extends Equatable {
  IntersectionTable({
    List<List<Intersection>>? data,
    required this.boardSize,
  })  : data = data ??
            List.generate(
              boardSize,
              (x) => List.generate(
                boardSize,
                (y) => Intersection(
                  x: x,
                  y: y,
                  stone: const EmptyStone(),
                ),
              ),
            ),
        assert(boardSize > 0);

  final List<List<Intersection>> data;
  final int boardSize;

  IntersectionTable copyWith({
    List<List<Intersection>>? data,
    int? boardSize,
  }) {
    return IntersectionTable(
      data: data ?? this.data,
      boardSize: boardSize ?? this.boardSize,
    );
  }

  IntersectionTable added(int x, int y, Stone stone) {
    final List<List<Intersection>> newData = List.generate(
      boardSize,
      (_x) => List.generate(
        boardSize,
        (_y) => (_x == x && _y == y)
            ? Intersection(x: x, y: y, stone: stone)
            : data[_x][_y],
      ),
    );
    return copyWith(data: newData);
  }

  IntersectionTable removed(int x, int y) {
    return added(x, y, const EmptyStone());
  }

  IntersectionTable withCallback(
    BuildContext context,
  ) {
    final List<List<Intersection>> newData = List.generate(
      boardSize,
      (x) => List.generate(
          boardSize,
          (y) => Intersection(
              x: x,
              y: y,
              stone: data[x][y].stone.copyWith(
                onPressed: () {
                  print('onPressed $x $y');
                  context.read<BoardBloc>().add(StonePressed(x, y));
                },
                onDoublePressed: () {
                  print('onDoublePressed $x $y');
                  context.read<BoardBloc>().add(StoneDoublePressed(x, y));
                },
                onHover: (event) {
                  print('onHover $x $y');
                  context.read<BoardBloc>().add(StoneHovered(x, y));
                },
              ))),
    );
    return copyWith(data: newData);
  }

  IntersectionTable transpose() {
    return copyWith(
      data: List.generate(
        boardSize,
        (x) => List.generate(
          boardSize,
          (y) => data[y][x],
        ),
      ),
    );
  }

  List<Intersection> flatten() {
    return data.expand((element) => element).toList();
  }

  @override
  List<Object> get props => data;

  @override
  String toString() {
    final List<List<Stone>> stones =
        data.map((row) => row.map((i) => i.stone).toList()).toList();
    return stones
        .map((row) => row.map((s) => s.toString()).join(' '))
        .join('\n');
  }
}
