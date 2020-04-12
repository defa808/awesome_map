import 'package:flutter/material.dart';

enum MyThemeKeys { LIGHT, DARK, DARKER }

class MyThemes {
  static final ThemeData lightTheme = getMixTheme(ThemeData.light()).copyWith(
    primaryColor: Colors.blue,
  );

  static final ThemeData darkTheme = getMixTheme(ThemeData.dark()).copyWith(
    brightness: Brightness.dark,
  );

  static final ThemeData darkerTheme = getMixTheme(ThemeData.dark()).copyWith(
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

  static getMixTheme(ThemeData themeData) {
    return themeData.copyWith(
      pageTransitionsTheme: PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }),
      toggleButtonsTheme: ToggleButtonsThemeData(
          color: themeData.brightness == Brightness.dark
              ? Colors.grey
              : Colors.grey,
          selectedColor: themeData.brightness == Brightness.dark
              ? Colors.white
              : Colors.blue,
          fillColor: themeData.brightness == Brightness.dark
              ? Colors.black12
              : Colors.white),
    );
  }
}
