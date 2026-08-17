import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentora/features/category_details/manager/category_details_state.dart';
import 'package:rentora/features/home/data/models/product_model.dart';
import '../data/repos/category_details_repo.dart';

class CategoryDetailsCubit extends Cubit<CategoryDetailsState> {
  final CategoryDetailsRepo _repo;

  CategoryDetailsCubit(this._repo) : super(CategoryDetailsInitial());

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  Future<void> getProductsByCategory(String categoryName) async {
    emit(CategoryDetailsLoading());

    final result = await _repo.getCategoryProducts(categoryName);

    result.fold((failure) => emit(CategoryDetailsError(failure.message)), (
      productsList,
    ) {
      _products = productsList;
      emit(CategoryDetailsLoaded(_products));
    });
  }
}
