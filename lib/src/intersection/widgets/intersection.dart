import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gobo/gobo.dart';

class Intersection extends StatelessWidget {
  const Intersection({
    super.key,
    required this.x,
    required this.y,
    required this.stone,
  });

  final int x;
  final int y;
  final Stone stone;

  @override
  Widget build(BuildContext context) {
    final int boardSize = BoardConfig.of(context).dimension.size;
    bool isTopMost = y == 0;
    bool isBottomMost = y == boardSize - 1;
    bool isLeftMost = x == 0;
    bool isRightMost = x == boardSize - 1;
    bool isStarPoint =
        (x == 3 || x == (boardSize / 2).floor() || x == boardSize - 1 - 3) &&
            (y == 3 || y == (boardSize / 2).floor() || y == boardSize - 1 - 3);

    final double lineThickness =
        BoardConfig.of(context).dimension.lineThickness;
    final double lineSpacing = BoardConfig.of(context).dimension.lineSpacing;
    final double starPointRadius =
        BoardConfig.of(context).dimension.starPointRadius;
    final double width = lineSpacing + lineThickness;
    final double height = lineSpacing + lineThickness;

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
        SvgPicture.string(rawSvg, width: width, height: height),
        stone,
      ],
    );
  }
}
