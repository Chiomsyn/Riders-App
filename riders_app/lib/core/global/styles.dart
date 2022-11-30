import 'package:flutter/material.dart';

import 'colors.dart';

class Styles {
  static ThemeData darkThemeData(BuildContext context) {
    return ThemeData(
      textTheme: const TextTheme(
          labelMedium: TextStyle(fontSize: 12, color: Colors.white70),
          titleLarge: TextStyle(
              color: Colors.blueAccent,
              fontSize: 20,
              fontWeight: FontWeight.bold),
          titleMedium: TextStyle(color: white, fontSize: 15),
          titleSmall: TextStyle(color: Colors.white70, fontSize: 15)),
      primarySwatch: Colors.blue,
      primaryColor: Colors.blueAccent,
      backgroundColor: const Color(0xff072846),
      indicatorColor: const Color(0xff0E1D36),
      hintColor: const Color(0xff280C0B),
      highlightColor: const Color(0xff372901),
      hoverColor: const Color(0xff3A3A3B),
      focusColor: const Color(0xff0B2512),
      disabledColor: Colors.grey,
      cardColor: const Color(0xFF151515),
      canvasColor: Colors.black,
      brightness: Brightness.dark,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: const ColorScheme.dark(),
          buttonColor: const Color(0xff2196F3)),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
      ),
    );
  }

  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.blue,
      textTheme: const TextTheme(
          labelMedium: TextStyle(fontSize: 12, color: grey),
          titleLarge: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(color: black, fontSize: 15),
          titleSmall: TextStyle(color: black, fontSize: 15)),
      primaryColor: Colors.blue,
      backgroundColor: Colors.white,
      indicatorColor: const Color(0xffCBDCF8),
      hintColor: const Color(0xffEECED3),
      highlightColor: const Color(0xffFCE192),
      hoverColor: const Color(0xff4285F4),
      focusColor: const Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      cardColor: Colors.white,
      canvasColor: Colors.grey[50],
      brightness: Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: const ColorScheme.light(),
          buttonColor: const Color(0xff0E77D1)),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
      ),
    );
  }

  static final Map<int, Color> _yellow700Map = {
    50: const Color(0xff2196F3),
    100: Colors.blue[100]!,
    200: Colors.blue[200]!,
    300: Colors.blue[300]!,
    400: Colors.blue[400]!,
    500: Colors.blue[500]!,
    600: Colors.blue[600]!,
    700: Colors.blue[800]!,
    800: Colors.blue[900]!,
    900: Colors.blue[700]!,
  };

  static final MaterialColor _yellow700Swatch =
      MaterialColor(Colors.blue[700]!.value, _yellow700Map);
}
