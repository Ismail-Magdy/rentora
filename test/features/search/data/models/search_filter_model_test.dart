import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/features/search/data/models/search_filter_model.dart';

void main() {
  group('SearchFilterModel Tests', () {
    final testDate = DateTime(2026, 5, 1, 10, 0);

    test(
      'default constructor should initialize with all null fields and isEmpty true',
      () {
        const filter = SearchFilterModel();

        expect(filter.text, isNull);
        expect(filter.category, isNull);
        expect(filter.minPrice, isNull);
        expect(filter.maxPrice, isNull);
        expect(filter.location, isNull);
        expect(filter.condition, isNull);
        expect(filter.startDate, isNull);
        expect(filter.endDate, isNull);
        expect(filter.isEmpty, isTrue);
      },
    );

    test('isEmpty should return false when at least one field is non-null', () {
      expect(const SearchFilterModel(text: 'camera').isEmpty, isFalse);
      expect(const SearchFilterModel(category: 'Gaming').isEmpty, isFalse);
      expect(const SearchFilterModel(minPrice: 10).isEmpty, isFalse);
      expect(const SearchFilterModel(maxPrice: 100).isEmpty, isFalse);
      expect(const SearchFilterModel(location: 'Cairo').isEmpty, isFalse);
      expect(const SearchFilterModel(condition: 'New').isEmpty, isFalse);
      expect(SearchFilterModel(startDate: testDate).isEmpty, isFalse);
      expect(SearchFilterModel(endDate: testDate).isEmpty, isFalse);
    });

    test('copyWith should update specified fields without mutating others', () {
      final initial = SearchFilterModel(
        text: 'Lens',
        category: 'Cameras',
        minPrice: 20,
        maxPrice: 80,
        location: 'Giza',
        condition: 'Good',
        startDate: testDate,
        endDate: testDate.add(const Duration(days: 3)),
      );

      final updated = initial.copyWith(text: 'Tripod', minPrice: 15);

      expect(updated.text, equals('Tripod'));
      expect(updated.category, equals('Cameras'));
      expect(updated.minPrice, equals(15));
      expect(updated.maxPrice, equals(80));
      expect(updated.location, equals('Giza'));
      expect(updated.condition, equals('Good'));
      expect(updated.startDate, equals(testDate));
      expect(updated.endDate, equals(testDate.add(const Duration(days: 3))));
    });

    test('copyWith should clear fields when clear flags are set to true', () {
      final initial = SearchFilterModel(
        text: 'Drone',
        category: 'Electronics',
        minPrice: 50,
        maxPrice: 200,
        location: 'Alex',
        condition: 'New',
        startDate: testDate,
        endDate: testDate,
      );

      final cleared = initial.copyWith(
        clearText: true,
        clearCategory: true,
        clearMinPrice: true,
        clearMaxPrice: true,
        clearLocation: true,
        clearCondition: true,
        clearStartDate: true,
        clearEndDate: true,
      );

      expect(cleared.isEmpty, isTrue);
      expect(cleared.text, isNull);
      expect(cleared.category, isNull);
      expect(cleared.minPrice, isNull);
      expect(cleared.maxPrice, isNull);
      expect(cleared.location, isNull);
      expect(cleared.condition, isNull);
      expect(cleared.startDate, isNull);
      expect(cleared.endDate, isNull);
    });

    test('fromJson should parse map with various value types', () {
      final json = {
        'text': 'GoPro',
        'category': 'Cameras',
        'minPrice': '30.5',
        'maxPrice': 150,
        'location': 'Cairo',
        'condition': 'Like New',
        'startDate': '2026-06-01T12:00:00.000',
        'endDate': '2026-06-05T12:00:00.000',
      };

      final filter = SearchFilterModel.fromJson(json);

      expect(filter.text, equals('GoPro'));
      expect(filter.category, equals('Cameras'));
      expect(filter.minPrice, equals(30.5));
      expect(filter.maxPrice, equals(150.0));
      expect(filter.location, equals('Cairo'));
      expect(filter.condition, equals('Like New'));
      expect(
        filter.startDate,
        equals(DateTime.parse('2026-06-01T12:00:00.000')),
      );
      expect(filter.endDate, equals(DateTime.parse('2026-06-05T12:00:00.000')));
    });

    test('toJson should convert SearchFilterModel to valid map', () {
      final filter = SearchFilterModel(
        text: 'Laptop',
        category: 'Tech',
        minPrice: 500.0,
        maxPrice: 1500.0,
        location: 'Nasr City',
        condition: 'New',
        startDate: testDate,
        endDate: testDate.add(const Duration(days: 2)),
      );

      final json = filter.toJson();

      expect(json['text'], equals('Laptop'));
      expect(json['category'], equals('Tech'));
      expect(json['minPrice'], equals(500.0));
      expect(json['maxPrice'], equals(1500.0));
      expect(json['location'], equals('Nasr City'));
      expect(json['condition'], equals('New'));
      expect(json['startDate'], equals(testDate.toIso8601String()));
      expect(
        json['endDate'],
        equals(testDate.add(const Duration(days: 2)).toIso8601String()),
      );
    });
  });
}
