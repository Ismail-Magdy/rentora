import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String userId;
  final String name;
  final String email;
  final String phoneNumber;
  final String? avatarUrl;
  final String bio;
  final GeoPoint? location;
  final String? locationName;
  final String? geohash;
  final List<String> interests;
  final String verificationStatus;
  final bool agreedToTerms;
  final String? fcmToken;
  final DateTime createdAt;

  const UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.avatarUrl,
    this.bio = '',
    this.location,
    this.locationName,
    this.geohash,
    this.interests = const [],
    this.verificationStatus = 'unverified',
    this.agreedToTerms = false,
    this.fcmToken,
    required this.createdAt,
  });

  factory UserModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return UserModel(
      userId: data['userId'] as String? ?? '',
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
      phoneNumber: data['phoneNumber'] as String? ?? '',
      avatarUrl: data['avatarUrl'] as String?,
      bio: data['bio'] as String? ?? '',
      location: data['location'] as GeoPoint?,
      locationName: data['locationName'] as String?,
      geohash: data['geohash'] as String?,
      interests: (data['interests'] as List<dynamic>? ?? [])
          .map((e) => e as String)
          .toList(),
      verificationStatus: data['verificationStatus'] as String? ?? 'unverified',
      agreedToTerms: data['agreedToTerms'] as bool? ?? false,
      fcmToken: data['fcmToken'] as String?,
      createdAt: _parseTimestamp(data['createdAt']),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'userId': userId,
    'name': name,
    'email': email,
    'phoneNumber': phoneNumber,
    'avatarUrl': avatarUrl,
    'bio': bio,
    'location': location,
    'locationName': locationName,
    'geohash': geohash,
    'interests': interests,
    'verificationStatus': verificationStatus,
    'agreedToTerms': agreedToTerms,
    'fcmToken': fcmToken,
    'createdAt': Timestamp.fromDate(createdAt),
  };

  static DateTime _parseTimestamp(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return DateTime.now();
  }

  @override
  List<Object?> get props => [
    userId,
    name,
    email,
    phoneNumber,
    avatarUrl,
    bio,
    location,
    locationName,
    geohash,
    interests,
    verificationStatus,
    agreedToTerms,
    fcmToken,
    createdAt,
  ];
}
