import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Import the widget from your app
import 'package:flutter_gobo/stones/black_stone.dart';

@widgetbook.UseCase(name: 'BlackStone', type: BlackStone, path: 'Stones')
Widget buildFavoriteButtonUseCase(BuildContext context) {
  return BlackStone(
      stoneRadius:
          context.knobs.double.slider(label: 'stoneRadius', min: 0, max: 100));
}
