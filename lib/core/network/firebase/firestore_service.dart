import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Set a document in Firestore (useful for user profiles, listings, etc)
  Future<void> setDocument({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.doc(path).set(data);
  }

  /// Add a new document to a collection (useful for creating new listings, etc)
  Future<String> addDocument({
    required String collectionPath,
    required Map<String, dynamic> data,
  }) async {
    final docRef = await _firestore.collection(collectionPath).add(data);
    return docRef.id;
  }

  /// Get a specific document from Firestore (useful for fetching user profiles, listings, etc)
  Future<DocumentSnapshot<Map<String, dynamic>>> getDocument({
    required String path,
  }) async {
    return await _firestore.doc(path).get();
  }

  /// Get all documents from a specific collection (useful for fetching all listings, etc)
  Future<QuerySnapshot<Map<String, dynamic>>> getCollection({
    required String path,
  }) async {
    return await _firestore.collection(path).get();
  }

  /// Update a specific document in Firestore (useful for updating user profiles, listings, etc)
  Future<void> updateDocument({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.doc(path).update(data);
  }

  /// Delete a specific document from Firestore (useful for deleting listings, etc)
  Future<void> deleteDocument({required String path}) async {
    await _firestore.doc(path).delete();
  }
}
