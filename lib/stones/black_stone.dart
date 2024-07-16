import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BlackStone extends StatelessWidget {
  final double stoneRadius;
  final String svgId;
  final double opacity = 1;
  const BlackStone({
    super.key,
    required this.stoneRadius,
    this.svgId = 'black-stone-radial-gradient',
  });

  @override
  Widget build(BuildContext context) {
    final String rawSvg = '''
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="${stoneRadius * 2}"
      height="${stoneRadius * 2}"
    >
      <defs><radialGradient r=".8" cx=".3" id="$svgId" cy=".3">
      <stop offset="0" stop-color="#777"/>
      <stop offset=".3" stop-color="#222"/>
      <stop offset="1" stop-color="#000"/>
      </radialGradient></defs>
      <circle
        fill="url(#$svgId)"
        fillOpacity="$opacity"
        r="$stoneRadius"
        cx="$stoneRadius"
        cy="$stoneRadius"
      />
    </svg>
  ''';

    return SvgPicture.string(
      rawSvg,
    );
  }
}
