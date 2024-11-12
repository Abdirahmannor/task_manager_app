import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'dart:io';

class WindowManagerHelper {
  static Future<void> initialize() async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      await windowManager.ensureInitialized();

      await windowManager.setTitle('Task Manager');
      await windowManager.setMinimumSize(const Size(1024, 768));
      await windowManager.setSize(const Size(1280, 800));

      if (Platform.isWindows) {
        doWhenWindowReady(() {
          appWindow.minSize = const Size(1024, 768);
          appWindow.size = const Size(1280, 800);
          appWindow.alignment = Alignment.center;
          appWindow.show();
        });
      }
    }
  }
}

class WindowTitleBar extends StatelessWidget {
  const WindowTitleBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!Platform.isWindows) return const SizedBox.shrink();

    return WindowTitleBarBox(
      child: Row(
        children: [
          Expanded(
            child: MoveWindow(),
          ),
          const WindowButtons(),
        ],
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final buttonColors = WindowButtonColors(
      iconNormal: isDark ? Colors.white : Colors.black,
      mouseOver: isDark ? Colors.grey[700]! : Colors.grey[300]!,
      mouseDown: isDark ? Colors.grey[800]! : Colors.grey[400]!,
      iconMouseOver: isDark ? Colors.white : Colors.black,
      iconMouseDown: isDark ? Colors.white : Colors.black,
    );

    final closeButtonColors = WindowButtonColors(
      mouseOver: Colors.red,
      mouseDown: Colors.red[700]!,
      iconNormal: isDark ? Colors.white : Colors.black,
      iconMouseOver: Colors.white,
    );

    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
