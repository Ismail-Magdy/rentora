import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/features/home/data/models/product_model.dart';
import 'package:rentora/features/home/data/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  HomeRepoImpl(this._firestore, this._firebaseAuth);

  @override
  Future<Either<Failure, List<String>>> getUserCategories() async {
    try {
      final List<String> defaultCategories = [
        'Cameras',
        'Gaming',
        'Sports',
        'Tools',
        'Books',
      ];

      final String userId = _firebaseAuth.currentUser?.uid ?? '';

      //

      if (userId.isEmpty) {
        return Right(defaultCategories);
      }

      final userDoc = await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists && userDoc.data() != null) {
        final data = userDoc.data()!;
        if (data.containsKey('interests')) {
          final List<dynamic> interestsData = data['interests'];
          if (interestsData.isNotEmpty) {
            final List<String> userInterests = List<String>.from(interestsData);
            return Right(userInterests);
          }
        }
      }

      return Right(defaultCategories);
    } on FirebaseException catch (e) {
      return Left(
        ServerFailure(
          e.message ?? 'Firebase Error: Failed to fetch categories.',
        ),
      );
    } catch (e) {
      return Left(
        ServerFailure(
          'An unexpected error occurred while fetching categories.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts({
    String? category,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _firestore.collection('products');

      if (category != null && category.isNotEmpty) {
        query = query.where('category', isEqualTo: category);
      }

      final QuerySnapshot<Map<String, dynamic>> snapshot = await query
          .limit(20)
          .get();

      final List<ProductModel> products = snapshot.docs.map((doc) {
        return ProductModel.fromJson(doc.data(), doc.id);
      }).toList();

      return Right(products);
    } on FirebaseException catch (e) {
      return Left(
        ServerFailure(e.message ?? 'Firebase Error: Failed to fetch products.'),
      );
    } catch (e) {
      return Left(
        ServerFailure('An unexpected error occurred while fetching products.'),
      );
    }
  }

  @override
  Future<Either<Failure, GeoPoint?>> getUserLocation() async {
    try {
      final String userId = _firebaseAuth.currentUser?.uid ?? '';
      if (userId.isEmpty) {
        return const Right(null);
      }

      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists && userDoc.data() != null) {
        final data = userDoc.data()!;
        if (data.containsKey('location') && data['location'] is GeoPoint) {
          return Right(data['location'] as GeoPoint);
        }
      }
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? 'Firebase Error: Failed to fetch location.'));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred while fetching location.'));
    }
  }
}
