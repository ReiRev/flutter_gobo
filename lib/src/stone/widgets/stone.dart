import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gobo/gobo.dart';

abstract class Stone extends StatelessWidget {
  const Stone({
    super.key,
    this.onPressed,
    this.onDoublePressed,
    this.onHover,
    this.mouseCursor = SystemMouseCursors.basic,
  });

  final VoidCallback? onPressed;
  final VoidCallback? onDoublePressed;
  final PointerHoverEventListener? onHover;
  final SystemMouseCursor mouseCursor;

  Widget render(BuildContext context);

  Stone copyWith({
    VoidCallback? onPressed,
    VoidCallback? onDoublePressed,
    PointerHoverEventListener? onHover,
    SystemMouseCursor? mouseCursor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
          shape: BoxShape.circle, color: Colors.transparent),
      height: BoardConfig.of(context).dimension.stoneRadius * 2,
      width: BoardConfig.of(context).dimension.stoneRadius * 2,
      child: GestureDetector(
        onTap: onPressed,
        onDoubleTap: onDoublePressed,
        child: MouseRegion(
          onHover: onHover,
          onEnter: (_) {
            print('onEnter');
          },
          onExit: (_) {
            print('onExit');
          },
          cursor: mouseCursor,
          child: render(context),
        ),
      ),

      // child: MouseRegion(
      //   onHover: (_) {
      //     print('onHover');
      //   },
      //   onEnter: (_) {
      //     print('onEnter');
      //   },
      //   onExit: (_) {
      //     print('onExit');
      //   },
      //   cursor: mouseCursor,
      //   child: render(context),
      //   // child: GestureDetector(
      //   //   onTap: onPressed,
      //   //   onDoubleTap: onDoublePressed,
      //   //   // onHover: widget.onHover,
      //   //   child: render(context),
      //   // ),
      // );,
    );
  }
}
