import 'package:flutter/material.dart';

final mainTheme = ThemeData(
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.lightBlueAccent,
      elevation: 0,
      titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700
      )
  ),
  colorScheme: const ColorScheme.light(),
  useMaterial3: true,
  textTheme: const TextTheme(
    labelSmall: TextStyle(
      color: Colors.indigoAccent,
      fontWeight: FontWeight.w700,
      fontSize: 14,
    ),
    labelMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 15,
    ),
    headlineSmall: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
  ),
);