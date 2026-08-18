import 'package:dartz/dartz.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/features/home/data/models/product_model.dart';
import 'category_details_repo.dart';

class CategoryDetailsRepoImpl implements CategoryDetailsRepo {
  @override
  Future<Either<Failure, List<ProductModel>>> getCategoryProducts(
    String categoryName,
  ) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      final dummyProducts = List.generate(
        6,
        (index) => ProductModel(
          id: 'cat_prod_$index',
          name: '$categoryName Item $index',
          price: 150.0 + (index * 10),
          rating: 4.5,
          distance: 2.0 + index,
          imageUrl:
              'https://dummyimage.com/400x300/cccccc/000000.png&text=$categoryName',
        ),
      );

      return Right(dummyProducts);
    } catch (e) {
      return Left(ServerFailure('Failed to load products for $categoryName'));
    }
  }
}
