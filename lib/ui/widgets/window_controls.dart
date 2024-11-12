import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'dart:io';

class WindowControls extends StatelessWidget {
  const WindowControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!Platform.isWindows) return const SizedBox.shrink();

    return Container(
      height: 32,
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onPanStart: (details) {
                windowManager.startDragging();
              },
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          _WindowButtons(),
        ],
      ),
    );
  }
}

class _WindowButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        MinimizeWindowButton(
          colors: WindowButtonColors(
            iconNormal: isDark ? Colors.white : Colors.black,
            mouseOver: isDark ? Colors.grey[700]! : Colors.grey[300]!,
            mouseDown: isDark ? Colors.grey[800]! : Colors.grey[400]!,
          ),
        ),
        MaximizeWindowButton(
          colors: WindowButtonColors(
            iconNormal: isDark ? Colors.white : Colors.black,
            mouseOver: isDark ? Colors.grey[700]! : Colors.grey[300]!,
            mouseDown: isDark ? Colors.grey[800]! : Colors.grey[400]!,
          ),
        ),
        CloseWindowButton(
          colors: WindowButtonColors(
            mouseOver: Colors.red,
            mouseDown: Colors.red[700]!,
            iconNormal: isDark ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}
