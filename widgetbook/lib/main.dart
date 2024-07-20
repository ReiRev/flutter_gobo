import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'main.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

class AppThemeData {
  AppThemeData({
    required this.color,
  });

  final Color color;
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      addons: [
        AlignmentAddon(initialAlignment: Alignment.center),
        DeviceFrameAddon(devices: Devices.all),
        InspectorAddon(enabled: true),
      ],
    );
  }
}
