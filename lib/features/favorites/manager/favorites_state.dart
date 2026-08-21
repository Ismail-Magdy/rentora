import 'package:flutter/foundation.dart';
import 'package:rentora/features/home/data/models/product_model.dart';

@immutable
abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<ProductModel> favorites;
  FavoritesLoaded(this.favorites);
}

class FavoritesActionSuccess extends FavoritesState {
  final String message;
  final bool isAdded;
  final String productId;
  final List<ProductModel> favorites;

  FavoritesActionSuccess({
    required this.message,
    required this.isAdded,
    required this.productId,
    required this.favorites,
  });
}

class FavoritesError extends FavoritesState {
  final String message;
  FavoritesError(this.message);
}
