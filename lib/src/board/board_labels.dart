import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/text.dart';

class BoardAxisLabel {
  final String Function(int index) indexToLabel;
  final TextPaint Function(double width, double height) textRenderer;
  final bool reversed;

  static TextPaint Function(double width, double height) defaultTextPaint =
      (double width, double height) => TextPaint(
            style: TextStyle(
              color: const Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Arial',
              fontSize: width * 0.8,
            ),
          );

  BoardAxisLabel({
    required this.indexToLabel,
    required this.textRenderer,
    this.reversed = false,
  });

  BoardAxisLabel.alphabetical({
    bool reversed = false,
    TextPaint Function(double width, double height)? textRenderer,
  }) : this(
            reversed: reversed,
            indexToLabel: (int index) {
              final int charCode = 'A'.codeUnitAt(0) + index;
              return String.fromCharCode(charCode);
            },
            textRenderer: textRenderer ?? defaultTextPaint);

  BoardAxisLabel.numerical({
    bool reversed = false,
    TextPaint Function(double width, double height)? textRenderer,
  }) : this(
            reversed: reversed,
            indexToLabel: (int index) {
              return (index + 1).toString();
            },
            textRenderer: textRenderer ?? defaultTextPaint);
}

class BoardAxesLabels {
  final BoardAxisLabel? top;
  final BoardAxisLabel? bottom;
  final BoardAxisLabel? left;
  final BoardAxisLabel? right;

  BoardAxesLabels({
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  BoardAxesLabels.none()
      : this(top: null, bottom: null, left: null, right: null);
}
