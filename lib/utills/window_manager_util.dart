import 'package:window_manager/window_manager.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

Future<void> configureWindow() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager
        .setMinimumSize(const Size(600, 600)); // Reduce minimum size
    await windowManager.show();
    await windowManager.setTitleBarStyle(
      TitleBarStyle.hidden,
      windowButtonVisibility: false,
    );
  });

  doWhenWindowReady(() {
    final win = appWindow;
    win.minSize = Size(600, 600); // Apply reduced minimum size
    win.size = Size(1024, 768);
    win.alignment = Alignment.center;
    win.show();
  });
}
