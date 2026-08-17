import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentora/core/helpers/constants.dart';
import 'package:rentora/features/create_listing/data/models/listing_entity.dart';

abstract class ListingRemoteDataSource {
  Future<DocumentSnapshot> getListing(String id);
  Future<void> createListing(Map<String, dynamic> data);
  Future<void> updateListing(String id, Map<String, dynamic> data);
}

class ListingRemoteDataSourceImpl implements ListingRemoteDataSource {
  final FirebaseFirestore _firestore;

  ListingRemoteDataSourceImpl(this._firestore);

  @override
  Future<DocumentSnapshot> getListing(String id) async {
    return await _firestore
        .collection(AppConstants.listingsCollection)
        .doc(id)
        .get();
  }

  @override
  Future<void> createListing(Map<String, dynamic> data) async {
    await _firestore.collection(AppConstants.listingsCollection).add(data);
  }

  @override
  Future<void> updateListing(String id, Map<String, dynamic> data) async {
    await _firestore
        .collection(AppConstants.listingsCollection)
        .doc(id)
        .update(data);
  }
}