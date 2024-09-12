import 'package:flutter/rendering.dart';
import 'package:flutter/painting.dart';

abstract final class StonePainters {
  static Paint invisible(double radius) =>
      Paint()..color = const Color(0x00000000);

  static Paint black(double radius) => Paint()..color = const Color(0xff000000);

  static Paint white(double radius) => Paint()
    ..color = const Color(0xffffffff)
    ..shader = const RadialGradient(
      colors: [
        Color(0xffffffff),
        Color(0xffffffff),
        Color(0xff000000),
        Color(0xff000000),
      ],
      radius: 0.5,
      stops: [0, 0.97, 0.97001, 1],
    ).createShader(
      Rect.fromCircle(
        center: Offset(radius, radius),
        radius: radius,
      ),
    );

  static Paint wikipediaBlack(double radius) => Paint()
    ..shader = const RadialGradient(
      colors: [
        Color(0xFF777777),
        Color(0xFF222222),
        Color(0xFF000000),
      ],
      stops: [0, 0.3, 1],
      radius: 0.8,
      center: Alignment(-0.3, -0.3),
    ).createShader(
      Rect.fromCircle(
        center: Offset(radius, radius),
        radius: radius,
      ),
    );

  static Paint wikipediaWhite(double radius) => Paint()
    ..shader = const RadialGradient(
      colors: [
        Color(0xffffffff),
        Color(0xffdddddd),
        Color(0xff777777),
      ],
      stops: [0.7, 0.9, 1],
      radius: 0.49,
      center: Alignment(-0.03, -0.01),
    ).createShader(
      Rect.fromCircle(
        center: Offset(radius, radius),
        radius: radius,
      ),
    );
}
