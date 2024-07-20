import 'package:flutter/material.dart';

class Intersection extends StatelessWidget {
  const Intersection({
    super.key,
    required this.intersectionRadius,
  });

  final double intersectionRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: intersectionRadius * 2,
      height: intersectionRadius * 2,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
    );
  }
}
