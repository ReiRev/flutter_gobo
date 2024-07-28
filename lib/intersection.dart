import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gobo/stone.dart';

class Intersection extends StatelessWidget {
  final double height;
  final double width;
  final Stone? stone;
  final double lineThickness;
  final bool isTopMost;
  final bool isBottomMost;
  final bool isLeftMost;
  final bool isRightMost;
  final bool isStarPoint;
  final double starPointRadius;
  final VoidCallback? onPressed;
  final VoidCallback? onDoublePressed;
  final VoidCallback? onHover;
  const Intersection({
    super.key,
    required this.height,
    required this.width,
    this.stone,
    this.lineThickness = 1,
    this.isTopMost = false,
    this.isBottomMost = false,
    this.isLeftMost = false,
    this.isRightMost = false,
    this.isStarPoint = false,
    this.starPointRadius = 3,
    this.onPressed,
    this.onDoublePressed,
    this.onHover,
  });

  @override
  Widget build(BuildContext context) {
    final String rawSvg = '''
      <svg
        xmlns="http://www.w3.org/2000/svg"
        width="$width"
        height="$height"
      >
        <line
          x1="${isLeftMost ? width / 2 : 0}"
          y1="${height / 2}"
          x2="${isRightMost ? width / 2 : width}"
          y2="${height / 2}"
          stroke="black"
          stroke-width="$lineThickness"
          stroke-linecap="square"
        />
        <line
          x1="${width / 2}"
          y1="${isTopMost ? height / 2 : 0}"
          x2="${width / 2}"
          y2="${isBottomMost ? height / 2 : height}"
          stroke="black"
          stroke-width="$lineThickness"
          stroke-linecap="square"
        />
        ${isStarPoint ? '''
          <circle
            cx="${width / 2}"
            cy="${height / 2}"
            r="$starPointRadius"
            fill="black"
          />
        ''' : ''}
      </svg>
    ''';

    return Stack(
      fit: StackFit.values[0],
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: onPressed,
          onDoubleTap: onDoublePressed,
          child: Container(
            clipBehavior: Clip.hardEdge,
            height: height,
            width: width,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: SvgPicture.string(rawSvg, width: width, height: height),
          ),
        ),
        stone != null ? Center(child: stone as Stone) : Container(),
      ],
    );
  }
}
