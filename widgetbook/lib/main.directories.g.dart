// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:widgetbook/widgetbook.dart' as _widgetbook;
import 'package:widgetbook_flutter_gobo/board.dart'
    as _widgetbook_flutter_gobo_board;
import 'package:widgetbook_flutter_gobo/game_editor.dart'
    as _widgetbook_flutter_gobo_game_editor;
import 'package:widgetbook_flutter_gobo/stone.dart'
    as _widgetbook_flutter_gobo_stone;
import 'package:widgetbook_flutter_gobo/symbol.dart'
    as _widgetbook_flutter_gobo_symbol;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookComponent(
    name: 'BoardComponent',
    useCases: [
      _widgetbook.WidgetbookUseCase(
        name: 'Basic Board',
        builder: _widgetbook_flutter_gobo_board.buildBoardUseCase,
      ),
      _widgetbook.WidgetbookUseCase(
        name: 'Book Board',
        builder: _widgetbook_flutter_gobo_board.buildBookBoardUseCase,
      ),
      _widgetbook.WidgetbookUseCase(
        name: 'Free Board',
        builder: _widgetbook_flutter_gobo_board.buildFreeBoardUseCase,
      ),
      _widgetbook.WidgetbookUseCase(
        name: 'Labelled Board',
        builder: _widgetbook_flutter_gobo_board.buildBoardWithLabelsUseCase,
      ),
    ],
  ),
  _widgetbook.WidgetbookLeafComponent(
    name: 'FlameGame',
    useCase: _widgetbook.WidgetbookUseCase(
      name: 'Game Editor',
      builder: _widgetbook_flutter_gobo_game_editor.buildGameEditor,
    ),
  ),
  _widgetbook.WidgetbookComponent(
    name: 'StoneComponent',
    useCases: [
      _widgetbook.WidgetbookUseCase(
        name: 'Black Stone',
        builder: _widgetbook_flutter_gobo_stone.buildBlackStoneUseCase,
      ),
      _widgetbook.WidgetbookUseCase(
        name: 'Invisible Stone',
        builder: _widgetbook_flutter_gobo_stone.buildInvisibleStoneUseCase,
      ),
      _widgetbook.WidgetbookUseCase(
        name: 'White Stone',
        builder: _widgetbook_flutter_gobo_stone.buildWhiteStoneUseCase,
      ),
      _widgetbook.WidgetbookUseCase(
        name: 'Wikipedia Black Stone',
        builder: _widgetbook_flutter_gobo_stone.buildWikipediaBlackStoneUseCase,
      ),
      _widgetbook.WidgetbookUseCase(
        name: 'Wikipedia White Stone',
        builder: _widgetbook_flutter_gobo_stone.buildWikipediaWhiteStoneUseCase,
      ),
    ],
  ),
  _widgetbook.WidgetbookComponent(
    name: 'SymbolComponent',
    useCases: [
      _widgetbook.WidgetbookUseCase(
        name: 'Circle',
        builder: _widgetbook_flutter_gobo_symbol.buildCircleUseCase,
      ),
      _widgetbook.WidgetbookUseCase(
        name: 'Square',
        builder: _widgetbook_flutter_gobo_symbol.buildSquareUseCase,
      ),
      _widgetbook.WidgetbookUseCase(
        name: 'Triangle',
        builder: _widgetbook_flutter_gobo_symbol.buildTriangleUseCase,
      ),
    ],
  ),
];
