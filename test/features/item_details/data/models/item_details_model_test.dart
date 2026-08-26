import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/features/item_details/data/models/item_details_model.dart';

void main() {
  group('ItemDetailsModel Tests', () {
    test('fromJson parses complete map correctly', () {
      final json = {
        'title': 'Canon EOS R5',
        'dailyPrice': 100.0,
        'rating': 4.9,
        'reviewsCount': 25,
        'distance': 3.5,
        'locationName': 'Cairo',
        'imageUrls': ['https://img.com/1.jpg'],
        'description': 'Professional 8K camera',
        'keyFeatures': ['8K RAW', 'Dual Card Slots'],
        'ownerId': 'owner_100',
        'ownerName': 'John Doe',
        'ownerAvatar': 'https://img.com/avatar.jpg',
        'ownerRating': 5.0,
        'isSuperHost': true,
        'ownerVerificationStatus': 'verified',
        'availableFrom': '2025-01-01T00:00:00.000',
        'availableTo': '2025-01-15T00:00:00.000',
        'isFavorite': true,
      };

      final model = ItemDetailsModel.fromJson(json, 'doc_123');

      expect(model.id, 'doc_123');
      expect(model.name, 'Canon EOS R5');
      expect(model.price, 100.0);
      expect(model.rating, 4.9);
      expect(model.reviewsCount, 25);
      expect(model.distance, 3.5);
      expect(model.isSuperHost, true);
      expect(model.isFavorite, true);
      expect(model.ownerName, 'John Doe');
    });

    test('toJson serializes model correctly', () {
      final model = ItemDetailsModel(
        id: 'doc_1',
        name: 'Tent',
        price: 20.0,
        rating: 4.5,
        distance: 1.0,
        description: 'Camping tent',
        keyFeatures: ['Waterproof'],
        ownerId: 'u1',
        ownerName: 'Ali',
      );

      final json = model.toJson();

      expect(json['name'], 'Tent');
      expect(json['price'], 20.0);
      expect(json['description'], 'Camping tent');
      expect(json['ownerName'], 'Ali');
    });
  });
}
