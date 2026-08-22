import 'dart:io';

import 'package:rentora/core/errors/exceptions.dart';
import 'package:rentora/core/errors/firebase_error_handler.dart';
import 'package:rentora/core/network/firebase/cloudinary_service.dart';
import 'package:rentora/core/network/firebase/firebase_auth_service.dart';
import 'package:rentora/core/network/firebase/users_firestore_service.dart';
import 'package:rentora/features/auth/data/models/user_model.dart';

class ProfileRepo {
  final UsersFirestoreService _usersService;
  final CloudinaryService _cloudinaryService;
  final FirebaseAuthService _authService;

  ProfileRepo({
    required UsersFirestoreService usersService,
    required CloudinaryService cloudinaryService,
    required FirebaseAuthService authService,
  }) : _usersService = usersService,
       _cloudinaryService = cloudinaryService,
       _authService = authService;

  String? get _currentUserId => _authService.getCurrentUserId();

  Future<UserModel> getProfile() async {
    final userId = _currentUserId;
    if (userId == null) {
      throw const ServerException('User not authenticated');
    }

    try {
      final doc = await _usersService.getUserProfile(userId: userId);
      if (!doc.exists) {
        throw const ServerException('User profile not found');
      }
      return UserModel.fromFirestore(doc);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(FirebaseErrorHandler.handle(e));
    }
  }

  Future<String> uploadAvatar(File imageFile) async {
    final url = await _cloudinaryService.uploadImage(imageFile);
    if (url == null) {
      throw const ServerException('Failed to upload image');
    }
    return url;
  }

  Future<UserModel> updateProfile({
    String? name,
    String? phoneNumber,
    String? bio,
    String? avatarUrl,
  }) async {
    final userId = _currentUserId;
    if (userId == null) {
      throw const ServerException('User not authenticated');
    }

    final updates = <String, dynamic>{};
    if (name != null) updates['name'] = name;
    if (phoneNumber != null) updates['phoneNumber'] = phoneNumber;
    if (bio != null) updates['bio'] = bio;
    if (avatarUrl != null) updates['avatarUrl'] = avatarUrl;

    try {
      await _usersService.updateUserProfile(
        userId: userId,
        updatedData: updates,
      );
      return await getProfile();
    } catch (e) {
      throw ServerException(FirebaseErrorHandler.handle(e));
    }
  }
}
