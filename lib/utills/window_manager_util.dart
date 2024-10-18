import 'package:window_manager/window_manager.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

Future<void> configureWindow() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setMinimumSize(const Size(600, 600));
    await windowManager.setTitleBarStyle(
      TitleBarStyle.hidden, // Hide the default system title bar
      windowButtonVisibility: false,
    );
    await windowManager.show();
  });

  doWhenWindowReady(() {
    final win = appWindow;
    win.minSize = const Size(600, 600);
    win.size = const Size(1024, 768);
    win.alignment = Alignment.center;
    win.show();
  });
}
