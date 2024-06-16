import 'package:flutter/material.dart';
import 'package:play/constant/font.dart';

final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.black,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle:
            TextStyle(fontFamily: AppFonts.poppinsBold, fontSize: 12),
        unselectedLabelStyle:
            TextStyle(fontFamily: AppFonts.poppinsLight, fontSize: 12)));

final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle:
            TextStyle(fontFamily: AppFonts.poppinsBold, fontSize: 12),
        unselectedLabelStyle:
            TextStyle(fontFamily: AppFonts.poppinsLight, fontSize: 12)));
