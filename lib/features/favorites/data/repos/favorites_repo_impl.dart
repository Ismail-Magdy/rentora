import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rentora/features/favorites/data/repos/favorites_repo.dart';
import 'package:rentora/features/home/data/models/product_model.dart';

class FavoritesRepoImpl implements FavoritesRepo {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  FavoritesRepoImpl(this._firestore, this._auth);

  String? get _userId => _auth.currentUser?.uid;

  @override
  Future<List<ProductModel>> getFavorites() async {
    if (_userId == null) return [];

    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .get();

      return snapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to load favorites');
    }
  }

  @override
  Future<void> addToFavorites(ProductModel product) async {
    if (_userId == null) throw Exception('User not logged in');

    try {
      final productData = product.toJson();
      productData['isFavorite'] = true;

      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .doc(product.id)
          .set(productData);
    } catch (e) {
      throw Exception('Failed to add to favorites');
    }
  }

  @override
  Future<void> removeFromFavorites(String productId) async {
    if (_userId == null) throw Exception('User not logged in');

    try {
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .doc(productId)
          .delete();
    } catch (e) {
      throw Exception('Failed to remove from favorites');
    }
  }
}
