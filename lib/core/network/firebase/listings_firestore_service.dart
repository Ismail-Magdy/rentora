import 'package:cloud_firestore/cloud_firestore.dart';

class ListingsFirestoreService {
  final FirebaseFirestore _firestore;

  ListingsFirestoreService(this._firestore);

  /// Creates a new rental item listing and lets Firestore generate a unique ID
  /// Returns the generated Document ID
  Future<String> createListing({
    required Map<String, dynamic> listingData,
  }) async {
    final docRef = await _firestore.collection("listings").add(listingData);
    return docRef.id;
  }

  /// Retrieves a list of available items based on a specific category.
  Future<QuerySnapshot<Map<String, dynamic>>> getListingsByCategory({
    required String categoryId,
  }) async {
    return await _firestore
        .collection("listings")
        .where("categoryId", isEqualTo: categoryId)
        .get();
  }

  /// Retrieves details of a single listing when a user clicks on an item card.
  Future<DocumentSnapshot<Map<String, dynamic>>> getListingDetails({
    required String listingId,
  }) async {
    return await _firestore.collection("listings").doc(listingId).get();
  }

  /* 
  CLASS SUMMARY:
  This class is the core engine for the Rentora marketplace feed. It handles 
  publishing new items for rent, and fetching items to display in the Home 
  grid or Map view, including filtering by categories.
  */
}
