import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:gobo/src/bloc/board_bloc.dart';
import 'package:flame/events.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/src/events/messages/position_event.dart';
import 'package:gobo/src/mixins/flame_bloc_reader_or_null.dart';
import 'dart:ui';

import 'package:gobo/src/models/coordinate.dart';

abstract class StoneComponent extends CircleComponent
    with TapCallbacks, FlameBlocReaderOrNull<BoardBloc, BoardState> {
  StoneComponent({
    super.radius,
    required this.painter,
    this.coordinate,
  }) : super(anchor: Anchor.center);

  Coordinate? coordinate;
  final Paint Function(double radius) painter;

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(
      Offset(radius, radius),
      radius,
      painter(radius),
    );
  }

  // @override
  // String toString();

  // TODO: enforce to assign coordinate
  // TODO: enforce to wrap with FlameBlocProvider
  @override
  void onTapDown(TapDownEvent event) {
    bloc?.add(TappedDown(coordinate!));
  }
}
