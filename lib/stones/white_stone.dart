import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WhiteStone extends StatelessWidget {
  final double radius;
  final String svgId;
  final double opacity;
  final VoidCallback? onPressed;
  final VoidCallback? onDoublePressed;
  const WhiteStone({
    super.key,
    required this.radius,
    this.opacity = 1,
    this.onPressed,
    this.onDoublePressed,
    this.svgId = 'rg',
  }); // Added super constructor call

  @override
  Widget build(BuildContext context) {
    final String rawSvg = '''
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
  ''';
    return Material(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        onDoubleTap: onDoublePressed,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: SvgPicture.string(
          rawSvg,
        ),
      ),
    );
  }
}
