import 'package:dartz/dartz.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentora/features/home/data/models/product_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<String>>> getUserCategories();

  Future<Either<Failure, List<ProductModel>>> getProducts({String? category});

  Future<Either<Failure, GeoPoint?>> getUserLocation();
}
