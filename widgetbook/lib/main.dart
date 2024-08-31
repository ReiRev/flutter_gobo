import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'main.directories.g.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    print('onEvent(${bloc.runtimeType}, $event)');
    super.onEvent(bloc, event);
  }
}

void main() {
  Bloc.observer = AppBlocObserver();
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
