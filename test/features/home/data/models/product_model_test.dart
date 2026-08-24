import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/features/home/data/models/product_model.dart';

void main() {
  group('ProductModel Tests', () {
    const docId = 'prod_123';

    test('fromJson should parse complete map correctly', () {
      final json = {
        'name': 'Canon EOS R5',
        'category': 'Cameras',
        'price': 120.0,
        'rating': 4.9,
        'distance': 1.2,
        'locationGeoPoint': const GeoPoint(30.0444, 31.2357),
        'locationName': 'Cairo, Egypt',
        'imageUrl': 'https://example.com/canon.jpg',
        'ownerId': 'owner_001',
        'isFavorite': true,
      };

      final product = ProductModel.fromJson(json, docId);

      expect(product.id, equals(docId));
      expect(product.name, equals('Canon EOS R5'));
      expect(product.category, equals('Cameras'));
      expect(product.price, equals(120.0));
      expect(product.rating, equals(4.9));
      expect(product.distance, equals(1.2));
      expect(product.latitude, equals(30.0444));
      expect(product.longitude, equals(31.2357));
      expect(product.locationName, equals('Cairo, Egypt'));
      expect(product.imageUrl, equals('https://example.com/canon.jpg'));
      expect(product.ownerId, equals('owner_001'));
      expect(product.isFavorite, isTrue);
    });

    test('fromJson should handle fallback keys and types', () {
      final json = {
        'title': 'Sony PlayStation 5',
        'category': 'Gaming',
        'dailyPrice': 50,
        'rating': 4.5,
        'distance': 3,
        'location': const GeoPoint(29.9869, 31.2831),
        'imageUrls': [
          'https://example.com/ps5_1.jpg',
          'https://example.com/ps5_2.jpg',
        ],
        'userId': 'user_999',
      };

      final product = ProductModel.fromJson(json, docId);

      expect(product.id, equals(docId));
      expect(product.name, equals('Sony PlayStation 5'));
      expect(product.category, equals('Gaming'));
      expect(product.price, equals(50.0));
      expect(product.latitude, equals(29.9869));
      expect(product.longitude, equals(31.2831));
      expect(product.imageUrl, equals('https://example.com/ps5_1.jpg'));
      expect(product.ownerId, equals('user_999'));
      expect(product.isFavorite, isFalse);
    });

    test('fromJson should handle empty or null fields with defaults', () {
      final json = <String, dynamic>{};
      final product = ProductModel.fromJson(json, docId);

      expect(product.id, equals(docId));
      expect(product.name, isEmpty);
      expect(product.category, isEmpty);
      expect(product.price, equals(0.0));
      expect(product.rating, equals(0.0));
      expect(product.distance, equals(0.0));
      expect(product.latitude, isNull);
      expect(product.longitude, isNull);
      expect(product.locationName, isEmpty);
      expect(product.imageUrl, isEmpty);
      expect(product.ownerId, isEmpty);
      expect(product.isFavorite, isFalse);
    });

    test('toJson should convert ProductModel to Map correctly', () {
      final product = ProductModel(
        id: docId,
        name: 'Tent 4-Person',
        category: 'Travel',
        price: 25.0,
        rating: 4.7,
        distance: 5.0,
        latitude: 31.2,
        longitude: 29.9,
        locationName: 'Alexandria',
        imageUrl: 'https://example.com/tent.jpg',
        isFavorite: true,
      );

      final json = product.toJson();

      expect(json['name'], equals('Tent 4-Person'));
      expect(json['category'], equals('Travel'));
      expect(json['price'], equals(25.0));
      expect(json['rating'], equals(4.7));
      expect(json['distance'], equals(5.0));
      expect(json['latitude'], equals(31.2));
      expect(json['longitude'], equals(29.9));
      expect(json['locationName'], equals('Alexandria'));
      expect(json['imageUrl'], equals('https://example.com/tent.jpg'));
      expect(json['isFavorite'], isTrue);
    });
  });
}
