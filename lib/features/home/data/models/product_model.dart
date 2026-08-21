import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String name;
  final String category;
  final double price;
  final double rating;
  final double distance;
  final double? latitude;
  final double? longitude;
  final String locationName;
  final String imageUrl;
  final String ownerId;
  final bool isFavorite;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.distance,
    this.latitude,
    this.longitude,
    this.locationName = '',
    required this.imageUrl,
    this.ownerId = '',
    this.isFavorite = false,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json, String documentId) {
    return ProductModel(
      id: documentId,
      name: json['title'] ?? json['name'] ?? '',
      category: json['category'] ?? '',
      price: (json['dailyPrice'] ?? json['price'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      distance: (json['distance'] ?? 0).toDouble(),
      latitude:
          (json['locationGeoPoint'] as GeoPoint?)?.latitude ??
          (json['location'] is GeoPoint
              ? (json['location'] as GeoPoint).latitude
              : null),
      longitude:
          (json['locationGeoPoint'] as GeoPoint?)?.longitude ??
          (json['location'] is GeoPoint
              ? (json['location'] as GeoPoint).longitude
              : null),
      locationName:
          json['locationName'] ??
          (json['location'] is String ? json['location'] : ''),
      imageUrl:
          (json['imageUrls'] != null && (json['imageUrls'] as List).isNotEmpty)
          ? json['imageUrls'][0]
          : (json['imageUrl'] ?? ''),
      ownerId: json['ownerId'] ?? json['userId'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'price': price,
      'rating': rating,
      'distance': distance,
      'latitude': latitude,
      'longitude': longitude,
      'locationName': locationName,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite,
    };
  }
}
