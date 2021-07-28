import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

class ThemeController {
  final BuildContext context;

  ThemeController({this.context});

  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
      Theme.of(context).brightness == Brightness.dark ? 
        Brightness.light : 
        Brightness.dark
    );
  }
  
  void changeColor() {
    DynamicTheme.of(context).setThemeData(
      new ThemeData(
        primaryColor: Theme.of(context).primaryColor == Colors.indigo ? 
          Colors.red : 
          Colors.indigo
      )
    );
  }
}