import 'package:cloud_firestore/cloud_firestore.dart';

class UsersFirestoreService {
  final FirebaseFirestore _firestore;

  UsersFirestoreService(this._firestore);

  /// Saves the initial user profile data to the 'users' collection after signup
  Future<void> createUserProfile({
    required String userId,
    required Map<String, dynamic> userData,
  }) async {
    await _firestore.collection("users").doc(userId).set(userData);
  }

  /// Retrieves the user's profile data as a Map
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfile({
    required String userId,
  }) async {
    return await _firestore.collection("users").doc(userId).get();
  }

  /// Updates specific fields in the user's profile (bio, location, avatar)
  Future<void> updateUserProfile({
    required String userId,
    required Map<String, dynamic> updatedData,
  }) async {
    await _firestore.collection("users").doc(userId).update(updatedData);
  }

  /* 
  CLASS SUMMARY:
  This class manages all interactions with the 'users' collection in Firestore.
  It handles creating the user document upon registration, fetching user details 
  for the profile screen, and updating user preferences (like categories) or 
  personal data (like avatars and locations).
  */
}
