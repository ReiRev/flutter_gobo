import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/text.dart';

typedef TextRenderer = TextPaint Function(double width, double height);

class BoardAxisLabel {
  final String Function(int index) indexToLabel;
  final TextRenderer textRenderer;
  final bool reversed;

  static TextRenderer Function(double scale) defaultTextRenderer =
      (double scale) => (double width, double height) => TextPaint(
            style: TextStyle(
              color: const Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Arial',
              fontSize: width * scale,
            ),
          );

  BoardAxisLabel({
    required this.indexToLabel,
    required this.textRenderer,
    this.reversed = false,
  });

  BoardAxisLabel.alphabetical({
    bool reversed = false,
    bool upperCase = true,
    double scale = 0.6,
    TextPaint Function(double width, double height)? textRenderer,
  }) : this(
          reversed: reversed,
          indexToLabel: (int index) {
            final int charCode = upperCase
                ? 'A'.codeUnitAt(0) + index
                : 'a'.codeUnitAt(0) + index;
            return String.fromCharCode(charCode);
          },
          textRenderer: textRenderer ?? defaultTextRenderer(scale),
        );

  BoardAxisLabel.numerical({
    bool reversed = false,
    double scale = 0.6,
    TextPaint Function(double width, double height)? textRenderer,
  }) : this(
          reversed: reversed,
          indexToLabel: (int index) {
            return (index + 1).toString();
          },
          textRenderer: textRenderer ?? defaultTextRenderer(scale),
        );
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

  List<TextComponent> createAxisLabels(
    int boardSize,
    double intersectionWidth,
    double intersectionHeight,
  ) {
    List<TextComponent> components = [];
    List<(BoardAxisLabel, Vector2 Function(int))> axisLabels = [
      if (top != null) ...[
        (
          top!,
          (int i) => Vector2(
                intersectionWidth * (i + 0.5),
                -intersectionHeight * 0.5,
              )
        ),
      ],
      if (bottom != null) ...[
        (
          bottom!,
          (int i) => Vector2(
                intersectionWidth * (i + 0.5),
                intersectionHeight * (boardSize + 0.5),
              )
        ),
      ],
      if (left != null) ...[
        (
          left!,
          (int i) => Vector2(
                -intersectionWidth * 0.5,
                intersectionHeight * (i + 0.5),
              )
        ),
      ],
      if (right != null) ...[
        (
          right!,
          (int i) => Vector2(
                intersectionWidth * (boardSize + 0.5),
                intersectionHeight * (i + 0.5),
              )
        ),
      ],
    ];

    for (int i = 0; i < boardSize; i++) {
      for (final axisLabel in axisLabels) {
        final label = axisLabel.$1;
        final position = axisLabel.$2(i);
        components.add(
          TextComponent(
            position: position,
            size: Vector2(intersectionWidth, intersectionHeight),
            text: label.reversed
                ? label.indexToLabel(boardSize - i - 1)
                : label.indexToLabel(i),
            anchor: Anchor.center,
            textRenderer: label.textRenderer(
              intersectionWidth,
              intersectionHeight,
            ),
          ),
        );
      }
    }

    return components;
  }
}
