import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum StoneVariant {
  empty,
  black,
  white,
}

class Stone extends StatefulWidget {
  final double radius;
  final String svgId;
  final double opacity;
  final VoidCallback? onPressed;
  final VoidCallback? onDoublePressed;
  final PointerHoverEventListener? onHover;
  final SystemMouseCursor mouseCursor;
  final StoneVariant variant;
  const Stone({
    super.key,
    required this.radius,
    this.opacity = 1,
    this.onPressed,
    this.onDoublePressed,
    this.onHover,
    this.mouseCursor = SystemMouseCursors.basic,
    this.svgId = 'rg',
    this.variant = StoneVariant.empty,
  }) : assert(0 <= opacity && opacity <= 1);

  const Stone.white({
    super.key,
    required this.radius,
    this.opacity = 1,
    this.onPressed,
    this.onDoublePressed,
    this.onHover,
    this.mouseCursor = SystemMouseCursors.basic,
    this.svgId = 'rg',
  })  : assert(0 <= opacity && opacity <= 1),
        variant = StoneVariant.white;

  const Stone.black({
    super.key,
    required this.radius,
    this.opacity = 1,
    this.onPressed,
    this.onDoublePressed,
    this.onHover,
    this.mouseCursor = SystemMouseCursors.basic,
    this.svgId = 'rg',
  })  : assert(0 <= opacity && opacity <= 1),
        variant = StoneVariant.black;

  @override
  State<Stone> createState() => _StoneState();
}

class _StoneState extends State<Stone> {
  late StoneVariant variant;

  @override
  void initState() {
    super.initState();
    variant = widget.variant;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return widget.variant.name;
  }

  // function to change variant
  void changeVariant(StoneVariant newVariant) {
    setState(() {
      variant = newVariant;
    });
  }

  String rawSvg() {
    switch (widget.variant) {
      case StoneVariant.empty:
        return '''
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="${widget.radius * 2}"
            height="${widget.radius * 2}"
          >
            <circle
              fill-opacity="0"
              r="${widget.radius}"
              cx="${widget.radius}"
              cy="${widget.radius}"
            />
          </svg>
        ''';

      case StoneVariant.black:
        return '''
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="${widget.radius * 2}"
            height="${widget.radius * 2}"
          >
            <defs><radialGradient r=".8" cx=".3" id="${widget.svgId}" cy=".3">
            <stop offset="0" stop-color="#777"/>
            <stop offset=".3" stop-color="#222"/>
            <stop offset="1" stop-color="#000"/>
            </radialGradient></defs>
            <circle
              fill="url(#${widget.svgId})"
              fill-opacity="${widget.opacity}"
              r="${widget.radius}"
              cx="${widget.radius}"
              cy="${widget.radius}"
            />
          </svg>
        ''';

      case StoneVariant.white:
        return '''
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="${widget.radius * 2}"
            height="${widget.radius * 2}"
          >
            <defs><radialGradient r=".48" cx=".47" id="${widget.svgId}" cy=".49">
            <stop offset=".7" stop-color="#FFF"/>
            <stop offset=".9" stop-color="#DDD"/>
            <stop offset="1" stop-color="#777"/>
            </radialGradient></defs>
            <circle
              fill="url(#${widget.svgId})"
              fill-opacity="${widget.opacity}"
              r="${widget.radius}"
              cx="${widget.radius}"
              cy="${widget.radius}"
            />
          </svg>
        ''';
      default:
        throw ArgumentError('Invalid variant: ${widget.variant}');
    }
  }

  String semanticLabelOf(StoneVariant variant) {
    switch (variant) {
      case StoneVariant.empty:
        return 'Empty Stone';

      case StoneVariant.black:
        return 'Black Stone';

      case StoneVariant.white:
        return 'White Stone';

      default:
        throw ArgumentError('Invalid variant: $variant');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
          shape: BoxShape.circle, color: Colors.transparent),
      height: widget.radius * 2,
      width: widget.radius * 2,
      child: MouseRegion(
          onHover: widget.onHover,
          cursor: widget.mouseCursor,
          child: GestureDetector(
              onTap: widget.onPressed,
              onDoubleTap: widget.onDoublePressed,
              // onHover: widget.onHover,
              child: SvgPicture.string(
                rawSvg(),
                clipBehavior: Clip.none,
              ))),
    );
  }
}
