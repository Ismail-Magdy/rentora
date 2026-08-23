import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends ChangeNotifier {
  SettingsController({
    ThemeMode themeMode = ThemeMode.light,
    Locale locale = const Locale('en'),
  }) : _themeMode = themeMode,
       _locale = locale;

  ThemeMode _themeMode;
  Locale _locale;

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> load() async {
    final preferences = await SharedPreferences.getInstance();
    _themeMode = preferences.getBool('dark_mode') == true
        ? ThemeMode.dark
        : ThemeMode.light;
    final language = preferences.getString('language_code');
    if (language == 'ar' || language == 'en') _locale = Locale(language!);
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('dark_mode', mode == ThemeMode.dark);
  }

  Future<void> setLocale(Locale locale) async {
    if (locale.languageCode != 'en' && locale.languageCode != 'ar') return;
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('language_code', locale.languageCode);
  }
}
