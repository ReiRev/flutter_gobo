import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gobo/gobo.dart';

class WhiteStone extends Stone {
  const WhiteStone({
    super.key,
    super.onPressed,
    super.onDoublePressed,
    super.onHover,
    super.mouseCursor,
    this.opacity = 1,
    this.svgId = 'rg',
  }) : assert(0 <= opacity && opacity <= 1);

  final double opacity;
  final String svgId;

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
            <defs><radialGradient r=".48" cx=".47" id="$svgId" cy=".49">
            <stop offset=".7" stop-color="#FFF"/>
            <stop offset=".9" stop-color="#DDD"/>
            <stop offset="1" stop-color="#777"/>
            </radialGradient></defs>
            <circle
              fill="url(#$svgId)"
              fill-opacity="$opacity"
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
  WhiteStone copyWith({
    VoidCallback? onPressed,
    VoidCallback? onDoublePressed,
    PointerHoverEventListener? onHover,
    SystemMouseCursor? mouseCursor,
    double? opacity,
    String? svgId,
  }) {
    return WhiteStone(
      onPressed: onPressed ?? this.onPressed,
      onDoublePressed: onDoublePressed ?? this.onDoublePressed,
      onHover: onHover ?? this.onHover,
      mouseCursor: mouseCursor ?? this.mouseCursor,
      opacity: opacity ?? this.opacity,
      svgId: svgId ?? this.svgId,
    );
  }
}
