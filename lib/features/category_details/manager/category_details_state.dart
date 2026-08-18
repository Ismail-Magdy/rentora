import 'package:rentora/features/home/data/models/product_model.dart';

abstract class CategoryDetailsState {}

class CategoryDetailsInitial extends CategoryDetailsState {}

class CategoryDetailsLoading extends CategoryDetailsState {}

class CategoryDetailsLoaded extends CategoryDetailsState {
  final List<ProductModel> products;

  CategoryDetailsLoaded(this.products);
}

class CategoryDetailsError extends CategoryDetailsState {
  final String error;
  CategoryDetailsError(this.error);
}
