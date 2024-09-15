import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/painting.dart';
import 'const.dart';

abstract final class StonePainters {
  static Paint invisible() => Paint()..color = const Color(0x00000000);

  static Paint black() => Paint()..color = Colors.black;

  static List<Paint> white() => [
        Paint()
          ..color = const Color(0xffffffff)
          ..style = PaintingStyle.fill,
        Paint()
          ..color = const Color(0xff000000)
          ..style = PaintingStyle.stroke
          ..strokeWidth = referenceStoneRadius * 0.01,
      ];

  // TODO: this is not the same as the wikipedia stones
  // but I have no time to fix it now
  static Paint wikipediaBlack() => Paint()
    ..shader = const RadialGradient(
      colors: [
        Color(0xFF777777),
        Color(0xFF222222),
        Color(0xFF000000),
      ],
      stops: [0, 0.3, 1],
      radius: 0.8,
      center: Alignment(0.6, 0.6),
    ).createShader(
      Rect.fromCircle(
        center: const Offset(0, 0),
        radius: referenceStoneRadius,
      ),
    );

  // TODO: this is not the same as the wikipedia stones
  // but I have no time to fix it now
  static Paint wikipediaWhite() => Paint()
    ..shader = const RadialGradient(
      colors: [
        Color(0xffffffff),
        Color(0xffdddddd),
        Color(0xff777777),
      ],
      stops: [0.7, 0.9, 1],
      radius: 0.48,
      center: Alignment(0.97, 0.99),
    ).createShader(
      Rect.fromCircle(
        center: const Offset(0, 0),
        radius: referenceStoneRadius,
      ),
    );
}
