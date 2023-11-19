import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  fontFamily: 'Poppins',
  colorScheme: const ColorScheme.light(
      background: Colors.white,
      primary: Colors.black,
      secondary: Colors.orange),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Poppins',
  useMaterial3: true,
  colorScheme: const ColorScheme.dark(
      background: Colors.black, primary: Colors.white, secondary: Colors.teal),
);
