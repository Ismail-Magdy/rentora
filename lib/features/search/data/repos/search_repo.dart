import 'package:dartz/dartz.dart';

import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/features/home/data/models/product_model.dart';

import '../models/search_filter_model.dart';


abstract class SearchRepo {
  Future<Either<Failure, List<ProductModel>>> searchListings(
    SearchFilterModel filter,
  );

}