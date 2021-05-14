import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData _themeLight = ThemeData.light();

ThemeData themeLight = _themeLight.copyWith(
  primaryTextTheme: TextTheme(
    subtitle1: TextStyle(color: Colors.white),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primaryColor: Colors.deepOrange[100],
  primaryColorLight: Colors.deepOrange[100],
  primaryColorDark: Colors.deepOrange[100],
  accentColor: Colors.black54,
  textTheme: _textLight(_themeLight.textTheme),
  cardTheme: _cardThemeLight(_themeLight.cardTheme),
  scaffoldBackgroundColor: Colors.white,
  inputDecorationTheme: _inputDecorationLight(_themeLight.inputDecorationTheme),
  buttonTheme: _buttonThemeLight(_themeLight.buttonTheme),
  appBarTheme: _appBarLight(_themeLight.appBarTheme),
  bottomNavigationBarTheme:
      _bottomNavigationBarLight(_themeLight.bottomNavigationBarTheme),
  dialogTheme: _dialogThemeLight(_themeLight.dialogTheme),
  chipTheme: ChipThemeData(
    backgroundColor: Colors.black54,
    selectedColor: Colors.deepOrange[100],
    disabledColor: Colors.black26,
    secondarySelectedColor: Colors.deepOrange[100],
    padding: EdgeInsets.all(5),
    labelStyle: TextStyle(color: Colors.white),
    secondaryLabelStyle: TextStyle(color: Colors.white),
    brightness: Brightness.light,
    showCheckmark: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
  ),
);

TextTheme _textLight(TextTheme base) {
  return base.copyWith(
    headline4: TextStyle(
      color: Colors.black54,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    headline6: TextStyle(color: Colors.black54),
    bodyText2: TextStyle(color: Colors.black54),
    subtitle2: TextStyle(color: Colors.black54),
  );
}

CardTheme _cardThemeLight(CardTheme base) {
  return base.copyWith(
    elevation: 5.0,
    clipBehavior: Clip.antiAlias,
    color: Colors.deepOrange[100],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    shadowColor: Colors.black,
  );
}

InputDecorationTheme _inputDecorationLight(InputDecorationTheme base) {
  return base.copyWith(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black54),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.deepOrange[100]),
    ),
  );
}

ButtonThemeData _buttonThemeLight(ButtonThemeData base) {
  return base.copyWith(
    buttonColor: Colors.deepOrange[100],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
  );
}

AppBarTheme _appBarLight(AppBarTheme base) {
  return base.copyWith(
    brightness: Brightness.dark,
    centerTitle: false,
    color: Colors.black54,
    iconTheme: IconThemeData(
      color: Colors.deepOrange[100],
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.deepOrange[100],
        fontSize: 18,
      ),
    ),
  );
}

BottomNavigationBarThemeData _bottomNavigationBarLight(
    BottomNavigationBarThemeData base) {
  return base.copyWith(
    backgroundColor: Colors.black54,
    selectedIconTheme: IconThemeData(
      color: Colors.deepOrange[100],
    ),
    selectedItemColor: Colors.deepOrange[100],
    unselectedIconTheme: IconThemeData(
      color: Colors.black54,
    ),
    unselectedItemColor: Colors.black54,
  );
}

DialogTheme _dialogThemeLight(DialogTheme base) {
  return base.copyWith(
    backgroundColor: Colors.white54,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
  );
}
