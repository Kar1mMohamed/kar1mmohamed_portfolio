import 'package:flutter/material.dart';

class MainTheme {
  MainTheme._();

  static final theme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    primarySwatch: Colors.blue,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
      brightness: Brightness.dark,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: Colors.black,
    fontFamily: 'Stinger',
    fontFamilyFallback: const ['Stinger', 'MyFont'],
  );
}
