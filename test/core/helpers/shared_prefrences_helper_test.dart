import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/core/helpers/shared_prefrences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('SharedPrefHelper', () {
    test('stores and retrieves supported value types', () async {
      await SharedPrefHelper.setData('name', 'Rentora');
      await SharedPrefHelper.setData('count', 7);
      await SharedPrefHelper.setData('enabled', true);
      await SharedPrefHelper.setData('ratio', 2.5);

      expect(await SharedPrefHelper.getString('name'), equals('Rentora'));
      expect(await SharedPrefHelper.getInt('count'), equals(7));
      expect(await SharedPrefHelper.getBool('enabled'), isTrue);
      expect(await SharedPrefHelper.getDouble('ratio'), equals(2.5));
    });

    test('returns default values when keys are missing', () async {
      expect(await SharedPrefHelper.getString('missing'), isEmpty);
      expect(await SharedPrefHelper.getInt('missing'), equals(0));
      expect(await SharedPrefHelper.getBool('missing'), isFalse);
      expect(await SharedPrefHelper.getDouble('missing'), equals(0.0));
    });

    test('removes and clears stored data', () async {
      await SharedPrefHelper.setData('token', 'abc');
      await SharedPrefHelper.setData('counter', 5);

      await SharedPrefHelper.removeData('token');

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('token'), isNull);
      expect(prefs.getInt('counter'), equals(5));

      await SharedPrefHelper.clearAllData();

      expect(prefs.getString('token'), isNull);
      expect(prefs.getInt('counter'), isNull);
      expect(prefs.getKeys(), isEmpty);
    });
  });
}
