import 'package:flutter/material.dart';

abstract class AppTheme {
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.transparent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.transparent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
