import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gobo/intersection.dart';
import 'package:gobo/stone.dart';
import 'package:gobo/utils.dart';

class Coordinate {
  final int x;
  final int y;

  Coordinate(this.x, this.y);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Coordinate($x, $y)';
  }
}

// TODO: reconsider the name of this class
class BoardAction {
  final Coordinate coordinate;
  final StoneVariant variant;
  BoardAction(this.coordinate, this.variant);
}

class Board extends StatefulWidget {
  final int size;
  late final double? width;
  late final double? height;
  late final double? stoneRadius;
  late final double? lineSpacing;
  late final double? lineThickness;
  late final double? starPointRadius;
  final void Function(Coordinate)? onPressed;
  final void Function(Coordinate)? onDoublePressed;
  final void Function(Coordinate)? onHover;
  // TOOD: reconsider the name of these streams
  final StreamController<BoardAction>? addStream;
  final StreamController<Coordinate>? removeStream;
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
      this.onPressed,
      this.onDoublePressed,
      this.onHover,
      this.addStream,
      this.removeStream,
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
  final onPressedController = StreamController<Coordinate>();
  final onDoublePressedController = StreamController<Coordinate>();
  final onHoverController = StreamController<Coordinate>();

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
                  stone: Stone(
                    radius: widget.stoneRadius!,
                    onPressed: () => onPressedController.add(Coordinate(x, y)),
                    onDoublePressed: () =>
                        onDoublePressedController.add(Coordinate(x, y)),
                    onHover: () => onHoverController.add(Coordinate(x, y)),
                  ),
                )));

    // boardState[3][0] = Intersection(
    //   height: widget.lineSpacing! + widget.lineThickness!,
    //   width: widget.lineSpacing! + widget.lineThickness!,
    //   lineThickness: widget.lineThickness!,
    //   stone: Stone.black(radius: widget.stoneRadius!),
    // );
    onPressedController.stream.listen((Coordinate coordinate) {
      widget.onPressed?.call(coordinate);
    });
    onDoublePressedController.stream.listen((Coordinate coordinate) {
      widget.onDoublePressed?.call(coordinate);
    });
    onHoverController.stream.listen((Coordinate coordinate) {
      widget.onHover?.call(coordinate);
    });
    widget.addStream?.stream.listen((BoardAction action) {
      addStone(action.coordinate.x, action.coordinate.y, action.variant);
    });
    widget.removeStream?.stream.listen((Coordinate coordinate) {
      removeStone(coordinate.x, coordinate.y);
    });
  }

  void addStone(int x, int y, StoneVariant variant) {
    setState(() {
      boardState[x][y] = Intersection(
          height: widget.lineSpacing! + widget.lineThickness!,
          width: widget.lineSpacing! + widget.lineThickness!,
          lineThickness: widget.lineThickness!,
          isTopMost: y == 0,
          isBottomMost: y == widget.size - 1,
          isLeftMost: x == 0,
          isRightMost: x == widget.size - 1,
          isStarPoint: isStarPoint(x, y),
          stone: Stone(
            radius: widget.stoneRadius!,
            onPressed: () => onPressedController.add(Coordinate(x, y)),
            onDoublePressed: () =>
                onDoublePressedController.add(Coordinate(x, y)),
            onHover: () => onHoverController.add(Coordinate(x, y)),
            variant: variant,
          ));
    });
  }

  void removeStone(int x, int y) {
    setState(() {
      boardState[x][y] = Intersection(
          height: widget.lineSpacing! + widget.lineThickness!,
          width: widget.lineSpacing! + widget.lineThickness!,
          lineThickness: widget.lineThickness!,
          isTopMost: y == 0,
          isBottomMost: y == widget.size - 1,
          isLeftMost: x == 0,
          isRightMost: x == widget.size - 1,
          isStarPoint: isStarPoint(x, y),
          stone: Stone(
            radius: widget.stoneRadius!,
            onPressed: () => onPressedController.add(Coordinate(x, y)),
            onDoublePressed: () =>
                onDoublePressedController.add(Coordinate(x, y)),
            onHover: () => onHoverController.add(Coordinate(x, y)),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      width: widget.width,
      height: widget.height,
      child: GridView.count(
        crossAxisCount: widget.size,
        children: transpose(boardState).expand((row) => row).toList(),
      ),
    );
  }
}
