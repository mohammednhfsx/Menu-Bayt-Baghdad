import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ThemeController extends GetxController {
  static const _key = 'isDark';
  // true = dark, false = light
  RxBool isDark = false.obs;
  @override
  void onInit() {
    super.onInit();
    _loadSavedTheme();
  }
  Future<void> _loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getBool(_key) ?? false;
    isDark.value = saved;
    _applyTheme();
  }
  Future<void> toggleTheme() async {
    isDark.value = !isDark.value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, isDark.value);
    _applyTheme();
  }
  Future<void> setDark(bool value) async {
    isDark.value = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, value);
    _applyTheme();
  }
  void _applyTheme() {
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }
}