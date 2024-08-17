import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class BoardTheme extends Equatable {
  const BoardTheme({
    this.boardColor = const Color.fromRGBO(214, 181, 105, 1),
  });

  final Color boardColor;

  @override
  List<Object?> get props => [boardColor];
}
