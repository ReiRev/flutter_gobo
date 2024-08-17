import 'package:equatable/equatable.dart';
import 'package:gobo/src/utils/unit.dart';

class BoardDimension extends Equatable {
  BoardDimension({
    this.size = 19,
    required this.width,
    double? height,
    double? stoneRadius,
    double? lineSpacing,
    double? lineThickness,
    double? starPointRadius,
  })  : height = height ?? width,
        stoneRadius =
            stoneRadius ?? 7.5 / 1.4.toBu(JapaneseUnit.shaku) * width / 2,
        lineSpacing =
            lineSpacing ?? 7.26 / 1.4.toBu(JapaneseUnit.shaku) * width,
        lineThickness =
            lineThickness ?? 0.3 / 1.4.toBu(JapaneseUnit.shaku) * width,
        starPointRadius =
            starPointRadius ?? 1.2 / 1.4.toBu(JapaneseUnit.shaku) * width;

  final int size;
  final double width;
  final double height;
  final double stoneRadius;
  final double lineSpacing;
  final double lineThickness;
  final double starPointRadius;

  @override
  List<Object?> get props => [width, height];
}
