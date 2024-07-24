import 'package:flutter/material.dart';
import 'package:gobo/intersection.dart';
import 'package:gobo/stone.dart';
import 'package:gobo/utils.dart';

class Board extends StatefulWidget {
  final int size;
  late final double? width;
  late final double? height;
  late final double? stoneRadius;
  late final double? lineSpacing;
  late final double? lineThickness;
  late final double? starPointRadius;
  final Color backgroundColor;

  Board(
      {super.key,
      this.size = 19,
      double? width,
      double? height,
      double? stoneRadius,
      double? lineSpacing,
      double? lineThickness,
      double? starPointRadius,
      this.backgroundColor = const Color.fromARGB(255, 31, 24, 7)}) {
    // the dimensions are based on Wikipedia.
    // https://en.wikipedia.org/wiki/Go_equipment
    this.width = width ?? height ?? 0;
    this.height = height ?? width;
    this.stoneRadius = stoneRadius ?? 7.5 / shaku2bu(1.4) * width! / 2;
    this.lineSpacing = lineSpacing ?? 7.26 / shaku2bu(1.4) * width!;
    this.lineThickness = lineThickness ?? 0.3 / shaku2bu(1.4) * width!;
    this.starPointRadius = starPointRadius ?? 1.2 / shaku2bu(1.4) * width!;
  }

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  late List<List<Intersection>> boardState;

  bool isStarPoint(int x, int y) {
    return (x == 3 ||
            x == (widget.size / 2).floor() ||
            x == widget.size - 1 - 3) &&
        (y == 3 || y == (widget.size / 2).floor() || y == widget.size - 1 - 3);
  }

  // TODO: make this faster
  List<List<Intersection>> transpose(List<List<Intersection>> intersections) {
    List<List<Intersection>> transposed =
        List.generate(widget.size, (int i) => []);
    intersections.asMap().forEach((int y, List<Intersection> row) {
      row.asMap().forEach((int x, Intersection intersection) {
        transposed[x].add(intersection);
      });
    });
    return transposed;
  }

  @override
  void initState() {
    super.initState();
    boardState = List.generate(
        widget.size,
        (x) => List.generate(
            widget.size,
            (y) => Intersection(
                  height: widget.lineSpacing! + widget.lineThickness!,
                  width: widget.lineSpacing! + widget.lineThickness!,
                  lineThickness: widget.lineThickness!,
                  isTopMost: y == 0,
                  isBottomMost: y == widget.size - 1,
                  isLeftMost: x == 0,
                  isRightMost: x == widget.size - 1,
                  isStarPoint: isStarPoint(x, y),
                )));

    boardState[3][0] = Intersection(
      height: widget.lineSpacing! + widget.lineThickness!,
      width: widget.lineSpacing! + widget.lineThickness!,
      lineThickness: widget.lineThickness!,
      stone: Stone.black(radius: widget.stoneRadius!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      width: widget.width,
      height: widget.height,
      child: GridView.count(
        crossAxisCount: widget.size,
        // children: boardState.expand((row) => row).toList(),
        children: transpose(boardState).expand((row) => row).toList(),
      ),
    );
  }
}
