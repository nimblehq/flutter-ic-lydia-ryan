import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';

class AppTheme {
  static ThemeData get defaultTheme => ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
        brightness: Brightness.light,
        fontFamily: Assets.fonts.neuzeitRegular,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 34.0,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
          titleSmall: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontSize: 17.0,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
          labelMedium: TextStyle(
            fontSize: 15.0,
            color: Colors.white,
          ),
        ),
      );
}
