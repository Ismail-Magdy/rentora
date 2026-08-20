import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/features/home/data/models/product_model.dart';
import 'category_details_repo.dart';

class CategoryDetailsRepoImpl implements CategoryDetailsRepo {
  final FirebaseFirestore _firestore;

  CategoryDetailsRepoImpl(this._firestore);

  @override
  Future<Either<Failure, List<ProductModel>>> getCategoryProducts(
    String categoryName,
  ) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('products')
          .where('category', isEqualTo: categoryName)
          .get();

      final List<ProductModel> products = snapshot.docs.map((doc) {
        return ProductModel.fromJson(doc.data(), doc.id);
      }).toList();

      return Right(products);
    } on FirebaseException catch (e) {
      return Left(
        ServerFailure(e.message ?? 'Firebase Error: Failed to load products.'),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to load products for $categoryName'));
    }
  }
}
