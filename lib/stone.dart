import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum _StoneVariant {
  standard,
  black,
  white,
}

class Stone extends StatelessWidget {
  final double radius;
  final String svgId;
  final double opacity;
  final VoidCallback? onPressed;
  final VoidCallback? onDoublePressed;
  final SystemMouseCursor mouseCursor;
  final _StoneVariant _stoneVariant;
  const Stone({
    super.key,
    required this.radius,
    this.opacity = 1,
    this.onPressed,
    this.onDoublePressed,
    this.mouseCursor = SystemMouseCursors.basic,
    this.svgId = 'rg',
  })  : assert(0 <= opacity && opacity <= 1),
        _stoneVariant = _StoneVariant.standard;

  const Stone.white({
    super.key,
    required this.radius,
    this.opacity = 1,
    this.onPressed,
    this.onDoublePressed,
    this.mouseCursor = SystemMouseCursors.basic,
    this.svgId = 'rg',
  })  : assert(0 <= opacity && opacity <= 1),
        _stoneVariant = _StoneVariant.white;

  const Stone.black({
    super.key,
    required this.radius,
    this.opacity = 1,
    this.onPressed,
    this.onDoublePressed,
    this.mouseCursor = SystemMouseCursors.basic,
    this.svgId = 'rg',
  })  : assert(0 <= opacity && opacity <= 1),
        _stoneVariant = _StoneVariant.black;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return _stoneVariant.name;
  }

  String rawSvg() {
    switch (_stoneVariant) {
      case _StoneVariant.standard:
        return '';

      case _StoneVariant.black:
        return '''
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="${radius * 2}"
            height="${radius * 2}"
          >
            <defs><radialGradient r=".8" cx=".3" id="$svgId" cy=".3">
            <stop offset="0" stop-color="#777"/>
            <stop offset=".3" stop-color="#222"/>
            <stop offset="1" stop-color="#000"/>
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

      case _StoneVariant.white:
        return '''
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
      default:
        throw ArgumentError('Invalid variant: $_stoneVariant');
    }
  }

  String semanticLabelOf(_StoneVariant variant) {
    switch (variant) {
      case _StoneVariant.standard:
        return 'Empty Stone';

      case _StoneVariant.black:
        return 'Black Stone';

      case _StoneVariant.white:
        return 'White Stone';

      default:
        throw ArgumentError('Invalid variant: $variant');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        onDoubleTap: onDoublePressed,
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: radius * 2,
          width: radius * 2,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Colors.transparent),
          child: SvgPicture.string(
            rawSvg(),
            clipBehavior: Clip.none,
          ),
        ));
  }
}
