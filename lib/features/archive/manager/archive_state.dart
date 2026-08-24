import 'package:equatable/equatable.dart';
import 'package:rentora/features/home/data/models/product_model.dart';

abstract class ArchiveState extends Equatable {
  const ArchiveState();

  @override
  List<Object> get props => [];
}

class ArchiveInitial extends ArchiveState {}

class ArchiveLoading extends ArchiveState {}

class ArchiveLoaded extends ArchiveState {
  final List<ProductModel> myProducts;

  const ArchiveLoaded({required this.myProducts});

  @override
  List<Object> get props => [myProducts];
}

class ArchiveError extends ArchiveState {
  final String message;

  const ArchiveError(this.message);

  @override
  List<Object> get props => [message];
}
