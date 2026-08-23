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
      // 1. Fetch all products from Firestore
      final snapshot = await _firestore.collection('products').get();

      List<ProductModel> allProducts = snapshot.docs.map((doc) {
        return ProductModel.fromJson(doc.data(), doc.id);
      }).toList();

      // 2. Also check listings collection if products is empty
      if (allProducts.isEmpty) {
        final listingsSnapshot = await _firestore.collection('listings').get();
        allProducts = listingsSnapshot.docs.map((doc) {
          return ProductModel.fromJson(doc.data(), doc.id);
        }).toList();
      }

      final searchText = filter.text?.trim().toLowerCase();
      final categoryFilter = filter.category?.trim().toLowerCase();
      final locationFilter = filter.location?.trim().toLowerCase();

      final filteredProducts = allProducts.where((product) {
        // Keyword text search (checks title/name, category, location)
        if (searchText != null && searchText.isNotEmpty) {
          final titleLower = product.name.toLowerCase();
          final categoryLower = product.category.toLowerCase();
          final locationLower = product.locationName.toLowerCase();

          final matches = titleLower.contains(searchText) ||
              categoryLower.contains(searchText) ||
              locationLower.contains(searchText);

          if (!matches) {
            return false;
          }
        }

        // Category filter (ignoring 'all')
        if (categoryFilter != null &&
            categoryFilter.isNotEmpty &&
            categoryFilter != 'all') {
          final prodCat = product.category.toLowerCase();
          if (!prodCat.contains(categoryFilter) &&
              !categoryFilter.contains(prodCat)) {
            return false;
          }
        }

        // Min Price filter
        if (filter.minPrice != null && filter.minPrice! > 0) {
          if (product.price < filter.minPrice!) {
            return false;
          }
        }

        // Max Price filter
        if (filter.maxPrice != null && filter.maxPrice! > 0) {
          if (product.price > filter.maxPrice!) {
            return false;
          }
        }

        // Location filter
        if (locationFilter != null && locationFilter.isNotEmpty) {
          if (!product.locationName.toLowerCase().contains(locationFilter)) {
            return false;
          }
        }

        return true;
      }).toList();

      return Right(filteredProducts);
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
