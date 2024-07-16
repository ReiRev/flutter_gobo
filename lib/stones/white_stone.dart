import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WhiteStone extends StatelessWidget {
  final double stoneRadius;
  final String svgId;
  final double opacity = 1;
  const WhiteStone({
    super.key,
    required this.stoneRadius,
    this.svgId = 'white-stone-radial-gradient',
  });

  @override
  Widget build(BuildContext context) {
    final String rawSvg = '''
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="${stoneRadius * 2}"
      height="${stoneRadius * 2}"
    >
      <defs><radialGradient r=".48" cx=".47" id="rg" cy=".49">
      <stop offset=".7" stop-color="#FFF"/>
      <stop offset=".9" stop-color="#DDD"/>
      <stop offset="1" stop-color="#777"/>
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
