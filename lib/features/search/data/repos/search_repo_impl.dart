import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/features/home/data/models/product_model.dart';

import '../models/search_filter_model.dart';

import 'search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  final FirebaseFirestore _firestore;

  SearchRepoImpl(this._firestore);

  @override
  Future<Either<Failure, List<ProductModel>>> searchListings(
    SearchFilterModel filter,
  ) async {
    try {
      Query<Map<String, dynamic>> query = _firestore.collection('products');

      if (filter.category != null && filter.category!.trim().isNotEmpty) {
        query = query.where('category', isEqualTo: filter.category!.trim());
      }

      if (filter.minPrice != null) {
        query = query.where(
          'dailyPrice',
          isGreaterThanOrEqualTo: filter.minPrice,
        );
      }

      if (filter.maxPrice != null) {
        query = query.where('dailyPrice', isLessThanOrEqualTo: filter.maxPrice);
      }

      if (filter.location != null && filter.location!.trim().isNotEmpty) {
        query = query.where('location', isEqualTo: filter.location!.trim());
      }

      if (filter.condition != null && filter.condition!.trim().isNotEmpty) {
        query = query.where('condition', isEqualTo: filter.condition!.trim());
      }

      final text = filter.text?.trim().toLowerCase();

      if (text != null && text.isNotEmpty) {
        query = query.orderBy('titleLower').startAt([text]).endAt([
          '$text\uf8ff',
        ]);
      }

      final snapshot = await query.get();

      final products = snapshot.docs.map((doc) {
        return ProductModel.fromJson(doc.data(), doc.id);
      }).toList();

      return Right(products);
    } on FirebaseException catch (e) {
      return Left(
        ServerFailure(
          e.message ?? 'Firebase Error: Failed to search products.',
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to search products.'));
    }
  }
}
