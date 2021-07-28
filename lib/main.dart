import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter_pics/views/home_page.dart';
import 'package:flutter_pics/config/theme_builder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => ThemeBuilder.buildTheme(brightness),
      themedWidgetBuilder: (context, theme) => MaterialApp(
        theme: theme,
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}