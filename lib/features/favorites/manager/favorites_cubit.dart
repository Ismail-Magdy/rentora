import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentora/features/favorites/manager/favorites_state.dart';
import 'package:rentora/features/home/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final SharedPreferences _prefs;
  static const String _favoritesKey = 'local_favorites';

  List<ProductModel> favorites = [];

  FavoritesCubit(this._prefs) : super(FavoritesInitial()) {
    getFavorites();
  }

  void getFavorites() {
    emit(FavoritesLoading());
    try {
      final list = _prefs.getStringList(_favoritesKey) ?? [];
      favorites = list.map((e) {
        final map = jsonDecode(e) as Map<String, dynamic>;
        return ProductModel.fromJson(map, map['id']);
      }).toList();
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> toggleFavorite(ProductModel product) async {
    final isFavorite = favorites.any((item) => item.id == product.id);

    try {
      if (isFavorite) {
        favorites.removeWhere((item) => item.id == product.id);
        await _saveToPrefs();
        emit(
          FavoritesActionSuccess(
            message: 'Removed from Favorites',
            isAdded: false,
            productId: product.id,
            favorites: List.from(favorites),
          ),
        );
      } else {
        favorites.add(product);
        await _saveToPrefs();
        emit(
          FavoritesActionSuccess(
            message: 'Added to Favorites',
            isAdded: true,
            productId: product.id,
            favorites: List.from(favorites),
          ),
        );
      }
      // Re-emit loaded state after success to maintain UI
      emit(FavoritesLoaded(List.from(favorites)));
    } catch (e) {
      emit(FavoritesError(e.toString()));
      emit(FavoritesLoaded(List.from(favorites))); // Restore loaded state on error
    }
  }

  Future<void> _saveToPrefs() async {
    final serializedList = favorites.map((e) {
      final data = e.toJson();
      data['id'] = e.id;
      return jsonEncode(data);
    }).toList();
    await _prefs.setStringList(_favoritesKey, serializedList);
  }

  bool isFavorite(String productId) {
    return favorites.any((item) => item.id == productId);
  }
}

