import 'package:flutter/material.dart';

class ThemeBuilder {
  static ThemeData buildTheme(Brightness brightness) {
    return brightness == Brightness.dark ? 
      ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: Colors.green,
          displayColor: Colors.green,
          fontFamily: 'Basier',
        ),
        backgroundColor: Colors.green,
        buttonColor: Colors.green,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.green
        )
      )
    : ThemeData.light().copyWith(
        textTheme: ThemeData.light().textTheme.apply(
          bodyColor: Colors.green,
          displayColor: Colors.green,
          fontFamily: 'Basier',
        ),
        backgroundColor: Colors.green,
      );
  }
}