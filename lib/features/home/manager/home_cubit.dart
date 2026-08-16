import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentora/features/home/data/models/product_model.dart';
import 'package:rentora/features/home/data/repos/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;

  HomeCubit(this._homeRepo) : super(HomeInitial());

  List<String> _categories = [];
  List<ProductModel> _products = [];

  Future<void> getHomeData() async {
    emit(HomeLoading());

    final categoriesResult = await _homeRepo.getUserCategories();

    categoriesResult.fold((failure) => emit(HomeError(failure.message)), (
      categories,
    ) async {
      _categories = categories;

      final productsResult = await _homeRepo.getProducts();

      productsResult.fold((failure) => emit(HomeError(failure.message)), (
        products,
      ) {
        _products = products;
        emit(
          HomeLoaded(
            categories: _categories,
            products: _products,
            selectedCategory: '',
          ),
        );
      });
    });
  }
}
