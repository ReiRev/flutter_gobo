import 'package:flutter/material.dart';
import 'package:gobo/gobo.dart';

class BoardConfigProvider extends StatelessWidget {
  const BoardConfigProvider({
    super.key,
    required this.dimension,
    BoardTheme? theme,
    required this.child,
  }) : theme = theme ?? const BoardTheme();

  final BoardDimension dimension;
  final BoardTheme theme;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BoardConfig(
      dimension: dimension,
      theme: theme,
      child: child,
    );
  }
}
