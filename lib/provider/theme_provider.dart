import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier
{
  ThemeData currenTheme;

  ThemeProvider({
    required bool isDarkmode

  }): currenTheme = isDarkmode ? ThemeData.dark() : ThemeData.light();

  setLightMode()
  {
    currenTheme = ThemeData.light();
    notifyListeners();
  }
  setDarkMode()
  {
    currenTheme = ThemeData.dark();
    notifyListeners();
  }

}