import 'package:dartz/dartz.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/features/home/data/models/product_model.dart';

abstract class CategoryDetailsRepo {
  Future<Either<Failure, List<ProductModel>>> getCategoryProducts(
    String categoryName,
  );
}
