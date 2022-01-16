import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFFFF0000);
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: primary,
    appBarTheme: const AppBarTheme(color: primary, elevation: 0),
    scaffoldBackgroundColor: primary,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: primary),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      extendedTextStyle: TextStyle(color: primary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: AppTheme.primary,
        shape: const StadiumBorder(),
      ),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(color: Colors.white, fontSize: 50),
      bodyText1: TextStyle(color: Colors.white, fontSize: 20),
    ),

  );
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
      primaryColor: primary,
      appBarTheme: const AppBarTheme(color: primary, elevation: 0),
      scaffoldBackgroundColor: Colors.black);
}
