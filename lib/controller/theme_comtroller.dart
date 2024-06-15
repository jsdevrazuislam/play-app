import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = true.obs;

  ThemeMode get theme => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme(value) {
    isDarkMode.value = !isDarkMode.value;
  }
}
