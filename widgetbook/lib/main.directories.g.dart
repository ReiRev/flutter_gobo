// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:widgetbook/widgetbook.dart' as _i1;
import 'package:widgetbook_flutter_gobo/board.dart' as _i2;
import 'package:widgetbook_flutter_gobo/intersection.dart' as _i3;
import 'package:widgetbook_flutter_gobo/stone.dart' as _i4;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookComponent(
    name: 'Board',
    useCases: [
      _i1.WidgetbookUseCase(
        name: 'Alternating Stone Board',
        builder: _i2.buildAlternatingStoneBoardUseCase,
      ),
      _i1.WidgetbookUseCase(
        name: 'Empty Board',
        builder: _i2.buildEmptyBoardUseCase,
      ),
    ],
  ),
  _i1.WidgetbookLeafComponent(
    name: 'Intersection',
    useCase: _i1.WidgetbookUseCase(
      name: 'Intersection',
      builder: _i3.buildIntersectionUseCase,
    ),
  ),
  _i1.WidgetbookComponent(
    name: 'Stone',
    useCases: [
      _i1.WidgetbookUseCase(
        name: 'Black Stone',
        builder: _i4.buildBlackStoneUseCase,
      ),
      _i1.WidgetbookUseCase(
        name: 'Empty Stone',
        builder: _i4.buildEmptyStoneUseCase,
      ),
      _i1.WidgetbookUseCase(
        name: 'White Stone',
        builder: _i4.buildWhiteStoneUseCase,
      ),
    ],
  ),
];
