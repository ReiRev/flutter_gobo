// import 'package:flutter/material.dart';
// import 'package:widgetbook/widgetbook.dart';
// import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// import 'package:gobo/stone.dart';
// import "../utils.dart";

// @widgetbook.UseCase(name: 'White Stone', type: Stone, path: 'Stones')
// Widget buildFavoriteButtonUseCase(BuildContext context) {
//   return Stone.white(
//     radius: context.knobs.double
//         .slider(label: 'radius', initialValue: 50, min: 1, max: 1000),
//     opacity: context.knobs.double
//         .slider(label: 'opacity', initialValue: 1, min: 0, max: 1),
//     onPressed: () {
//       popup(context, 'pressed');
//     },
//     onDoublePressed: () {
//       popup(context, 'double pressed');
//     },
//   );
// }
