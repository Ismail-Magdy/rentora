import 'package:cloud_firestore/cloud_firestore.dart';

class ItemDetailsModel {
  final String id;
  final String name;
  final double price;
  final double rating;
  final int reviewsCount;
  final double distance;
  final String locationName;
  final List<String> imageUrls;
  final String description;
  final List<String> keyFeatures;
  final String ownerId;
  final String ownerName;
  final String ownerAvatar;
  final double ownerRating;
  final bool isSuperHost;
  final List<DateTime> bookedDates;
  final bool isFavorite;

  ItemDetailsModel({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    this.reviewsCount = 0,
    required this.distance,
    this.locationName = '',
    this.imageUrls = const [],
    this.description = '',
    this.keyFeatures = const [],
    this.ownerId = '',
    this.ownerName = '',
    this.ownerAvatar = '',
    this.ownerRating = 0.0,
    this.isSuperHost = false,
    this.bookedDates = const [],
    this.isFavorite = false,
  });

  factory ItemDetailsModel.fromJson(
    Map<String, dynamic> json,
    String documentId,
  ) {
    return ItemDetailsModel(
      id: documentId,
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      reviewsCount: json['reviewsCount'] ?? 0,
      distance: (json['distance'] ?? 0).toDouble(),
      locationName: json['locationName'] ?? '',
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      description: json['description'] ?? '',
      keyFeatures: List<String>.from(json['keyFeatures'] ?? []),
      ownerId: json['ownerId'] ?? '',
      ownerName: json['ownerName'] ?? '',
      ownerAvatar: json['ownerAvatar'] ?? '',
      ownerRating: (json['ownerRating'] ?? 0).toDouble(),
      isSuperHost: json['isSuperHost'] ?? false,
      bookedDates:
          (json['bookedDates'] as List<dynamic>?)?.map((timestamp) {
            if (timestamp is Timestamp) {
              return timestamp.toDate();
            } else if (timestamp is DateTime) {
              return timestamp;
            }
            return DateTime.now();
          }).toList() ??
          [],
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'distance': distance,
      'locationName': locationName,
      'imageUrls': imageUrls,
      'description': description,
      'keyFeatures': keyFeatures,
      'ownerId': ownerId,
      'ownerName': ownerName,
      'ownerAvatar': ownerAvatar,
      'ownerRating': ownerRating,
      'isSuperHost': isSuperHost,
      'bookedDates': bookedDates,
      'isFavorite': isFavorite,
    };
  }
}
