import 'package:flutter/material.dart';

class ThemeToggle extends StatelessWidget {
  final ThemeMode themeMode;
  final Function(ThemeMode) onThemeChanged;

  const ThemeToggle({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final icon = isDark ? Icons.wb_sunny : Icons.nightlight_round;

    return IconButton(
      icon: Icon(icon),
      onPressed: () => onThemeChanged(themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark),
    );
  }
}