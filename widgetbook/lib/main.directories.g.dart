// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:widgetbook/widgetbook.dart' as _i1;
import 'package:widgetbook_flutter_gobo/intersection.dart' as _i2;
import 'package:widgetbook_flutter_gobo/stone.dart' as _i3;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookLeafComponent(
    name: 'Intersection',
    useCase: _i1.WidgetbookUseCase(
      name: 'Black Stone',
      builder: _i2.buildIntersectionUseCase,
    ),
  ),
  _i1.WidgetbookComponent(
    name: 'Stone',
    useCases: [
      _i1.WidgetbookUseCase(
        name: 'Black Stone',
        builder: _i3.buildBlackStoneUseCase,
      ),
      _i1.WidgetbookUseCase(
        name: 'White Stone',
        builder: _i3.buildWhiteStoneUseCase,
      ),
    ],
  ),
];
