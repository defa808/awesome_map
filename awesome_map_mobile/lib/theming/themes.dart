import 'package:flutter/material.dart';

enum MyThemeKeys { LIGHT, DARK, DARKER }

class MyThemes {
  static final ThemeData standartTheme = ThemeData(
      pageTransitionsTheme: PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }),
      primarySwatch: Colors.blue,
      textTheme: TextTheme(
          headline: TextStyle(
              fontSize: 72.0, fontFamily: 'Adventure', color: Colors.white),
          body2: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.bold),
          body1: TextStyle(fontFamily: 'Lato')));

  static final ThemeData lightTheme = standartTheme.copyWith(
    primaryColor: Colors.blue,
    brightness: Brightness.light,
  );

  static final ThemeData darkTheme = standartTheme.copyWith(
    primaryColor: Colors.grey,
    brightness: Brightness.dark,
  );

  static final ThemeData darkerTheme = standartTheme.copyWith(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
  );

  static ThemeData getThemeFromKey(MyThemeKeys themeKey) {
    switch (themeKey) {
      case MyThemeKeys.LIGHT:
        return lightTheme;
      case MyThemeKeys.DARK:
        return darkTheme;
      case MyThemeKeys.DARKER:
        return darkerTheme;
      default:
        return lightTheme;
    }
  }
}
