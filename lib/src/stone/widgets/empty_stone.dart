import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gobo/gobo.dart';

class EmptyStone extends Stone {
  const EmptyStone({
    super.key,
    super.onPressed,
    super.onDoublePressed,
    super.onHover,
    super.mouseCursor,
  });

  @override
  Widget render(BuildContext context) {
    final radius = BoardConfig.of(context).dimension.stoneRadius;
    return SvgPicture.string(
      '''
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="${radius * 2}"
            height="${radius * 2}"
          >
            <circle
              fill-opacity="0"
              r="$radius"
              cx="$radius"
              cy="$radius"
            />
          </svg>
        ''',
      clipBehavior: Clip.none,
    );
  }

  @override
  EmptyStone copyWith({
    VoidCallback? onPressed,
    VoidCallback? onDoublePressed,
    PointerHoverEventListener? onHover,
    SystemMouseCursor? mouseCursor,
  }) {
    return EmptyStone(
      onPressed: onPressed ?? this.onPressed,
      onDoublePressed: onDoublePressed ?? this.onDoublePressed,
      onHover: onHover ?? this.onHover,
      mouseCursor: mouseCursor ?? this.mouseCursor,
    );
  }
}
