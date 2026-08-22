import 'package:equatable/equatable.dart';
import 'package:rentora/features/home/data/models/product_model.dart';

abstract class ViewMapState extends Equatable {
  const ViewMapState();

  @override
  List<Object?> get props => [];
}

class ViewMapInitial extends ViewMapState {}

class ViewMapLoading extends ViewMapState {}

class ViewMapLoaded extends ViewMapState {
  final List<ProductModel> products;
  final double userLatitude;
  final double userLongitude;
  final String userFirstName;

  const ViewMapLoaded({
    required this.products,
    required this.userLatitude,
    required this.userLongitude,
    required this.userFirstName,
  });

  @override
  List<Object?> get props => [
    products,
    userLatitude,
    userLongitude,
    userFirstName,
  ];
}

class ViewMapError extends ViewMapState {
  final String error;

  const ViewMapError(this.error);

  @override
  List<Object?> get props => [error];
}
