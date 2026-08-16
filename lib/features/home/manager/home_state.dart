part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<String> categories;
  final List<ProductModel> products;
  final String selectedCategory;

  HomeLoaded({
    required this.categories,
    required this.products,
    required this.selectedCategory,
  });
}

class HomeError extends HomeState {
  final String error;
  HomeError(this.error);
}
