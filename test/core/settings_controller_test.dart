import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/core/settings_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({
      'dark_mode': true,
      'language_code': 'ar',
    });
  });

  group('SettingsController', () {
    test('loads theme mode and locale from shared preferences', () async {
      final controller = SettingsController();

      await controller.load();

      expect(controller.themeMode, equals(ThemeMode.dark));
      expect(controller.locale.languageCode, equals('ar'));
      expect(controller.isDarkMode, isTrue);
    });

    test('persists theme mode changes', () async {
      final controller = SettingsController();

      await controller.setThemeMode(ThemeMode.dark);

      final prefs = await SharedPreferences.getInstance();
      expect(controller.themeMode, equals(ThemeMode.dark));
      expect(prefs.getBool('dark_mode'), isTrue);
    });

    test('persists valid locale changes and ignores unsupported locales',
        () async {
      final controller = SettingsController(locale: const Locale('ar'));

      await controller.setLocale(const Locale('en'));

      final prefs = await SharedPreferences.getInstance();
      expect(controller.locale.languageCode, equals('en'));
      expect(prefs.getString('language_code'), equals('en'));

      await controller.setLocale(const Locale('fr'));

      expect(controller.locale.languageCode, equals('en'));
      expect(prefs.getString('language_code'), equals('en'));
    });
  });
}
