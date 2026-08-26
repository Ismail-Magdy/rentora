import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/features/favorites/manager/favorites_cubit.dart';
import 'package:rentora/features/favorites/manager/favorites_state.dart';
import 'package:rentora/features/home/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SharedPreferences prefs;
  late ProductModel product;
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    product = ProductModel(
      id: 'p1',
      name: 'Camera',
      category: 'Tech',
      price: 10,
      rating: 4,
      distance: 1,
      imageUrl: 'url',
    );
  });

  test('loads empty favorites initially', () {
    final cubit = FavoritesCubit(prefs);
    expect(cubit.state, isA<FavoritesLoaded>());
    expect(cubit.favorites, isEmpty);
    cubit.close();
  });

  test('adds and removes a favorite and persists it', () async {
    final cubit = FavoritesCubit(prefs);
    await cubit.toggleFavorite(product);
    expect(cubit.isFavorite('p1'), isTrue);
    expect(cubit.state, isA<FavoritesLoaded>());
    expect(prefs.getStringList('local_favorites'), hasLength(1));
    await cubit.toggleFavorite(product);
    expect(cubit.isFavorite('p1'), isFalse);
    expect(prefs.getStringList('local_favorites'), isEmpty);
    await cubit.close();
  });
}
