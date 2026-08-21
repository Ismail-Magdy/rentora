import 'package:rentora/features/home/data/models/product_model.dart';

abstract class FavoritesRepo {
  Future<List<ProductModel>> getFavorites();
  Future<void> addToFavorites(ProductModel product);
  Future<void> removeFromFavorites(String productId);
}
