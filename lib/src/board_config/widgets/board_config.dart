import 'package:flutter/material.dart';
import 'package:gobo/gobo.dart';

class BoardConfig extends InheritedWidget {
  const BoardConfig({
    super.key,
    required this.dimension,
    BoardTheme? theme,
    required super.child,
  }) : theme = theme ?? const BoardTheme();

  final BoardDimension dimension;
  final BoardTheme theme;

  static BoardConfig of(BuildContext context) {
    final BoardConfig? boardConfig =
        context.dependOnInheritedWidgetOfExactType<BoardConfig>();
    assert(boardConfig != null, 'No BoardConfig found');
    return boardConfig!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return false;
  }
}
