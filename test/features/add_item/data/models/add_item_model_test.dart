import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/features/add_item/data/models/add_item_model.dart';

void main() {
  group('AddItemModel', () {
    final created = DateTime(2026, 1, 1);
    final model = AddItemModel(
      id: 'i1',
      userId: 'u1',
      category: 'Camera',
      title: 'A camera',
      description: 'Good',
      condition: 'new',
      dailyPrice: 20,
      securityDeposit: 100,
      location: 'Cairo',
      locationGeoPoint: const GeoPoint(30, 31),
      imageUrls: const ['a', 'b'],
      createdAt: created,
      keyFeatures: const ['4K'],
      availableFrom: created,
      availableTo: DateTime(2026, 2, 1),
    );

    test('serializes and parses complete data', () {
      final result = AddItemModel.fromMap('i1', model.toMap());
      expect(result.id, 'i1');
      expect(result.title, 'A camera');
      expect(result.dailyPrice, 20);
      expect(result.locationGeoPoint, const GeoPoint(30, 31));
      expect(result.imageUrls, ['a', 'b']);
      expect(result.keyFeatures, ['4K']);
      expect(result.availableTo, DateTime(2026, 2, 1));
    });

    test('uses defaults for missing values', () {
      final result = AddItemModel.fromMap('x', {});
      expect(result.id, 'x');
      expect(result.userId, '');
      expect(result.dailyPrice, 0);
      expect(result.isAvailable, isTrue);
      expect(result.availableFrom, isNull);
    });
  });
}
