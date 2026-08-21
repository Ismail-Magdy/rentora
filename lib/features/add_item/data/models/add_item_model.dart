import 'package:cloud_firestore/cloud_firestore.dart';

class AddItemModel {
  String id;
  final String userId;
  final String category;
  final String title;
  final String description;
  final String condition;
  final double dailyPrice;
  final double securityDeposit;
  final String location;
  final GeoPoint? locationGeoPoint;
  final List<String> imageUrls;
  final DateTime createdAt;
  bool isAvailable;
  final double rating;
  final List<String> keyFeatures;
  final DateTime? availableFrom;
  final DateTime? availableTo;

  AddItemModel({
    this.id = '',
    required this.userId,
    required this.category,
    required this.title,
    required this.description,
    required this.condition,
    required this.dailyPrice,
    required this.securityDeposit,
    required this.location,
    this.locationGeoPoint,
    required this.imageUrls,
    required this.createdAt,
    this.isAvailable = true,
    this.rating = 0.0,
    this.keyFeatures = const [],
    this.availableFrom,
    this.availableTo,
  });

  Map<String, dynamic> toMap() => {
    'userId': userId,
    'category': category,
    'title': title,
    'description': description,
    'condition': condition,
    'dailyPrice': dailyPrice,
    'securityDeposit': securityDeposit,
    'location': location,
    'locationGeoPoint': locationGeoPoint,
    'imageUrls': imageUrls,
    'createdAt': createdAt.toIso8601String(),
    'isAvailable': isAvailable,
    'rating': rating,
    'keyFeatures': keyFeatures,
    'availableFrom': availableFrom?.toIso8601String(),
    'availableTo': availableTo?.toIso8601String(),
  };

  factory AddItemModel.fromMap(String id, Map<String, dynamic> map) =>
      AddItemModel(
        id: id,
        userId: map['userId'] ?? '',
        category: map['category'] ?? '',
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        condition: map['condition'] ?? '',
        dailyPrice: (map['dailyPrice'] ?? 0).toDouble(),
        securityDeposit: (map['securityDeposit'] ?? 0).toDouble(),
        location: map['location'] ?? '',
        locationGeoPoint: map['locationGeoPoint'],
        imageUrls: List<String>.from(map['imageUrls'] ?? []),
        createdAt: DateTime.parse(
          map['createdAt'] ?? DateTime.now().toIso8601String(),
        ),
        isAvailable: map['isAvailable'] ?? true,
        rating: (map['rating'] ?? 0.0).toDouble(),
        keyFeatures: List<String>.from(map['keyFeatures'] ?? []),
        availableFrom: map['availableFrom'] != null ? DateTime.parse(map['availableFrom']) : null,
        availableTo: map['availableTo'] != null ? DateTime.parse(map['availableTo']) : null,
      );
}
