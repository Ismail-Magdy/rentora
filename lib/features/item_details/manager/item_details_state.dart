part of 'item_details_cubit.dart';

abstract class ItemDetailsState {}

class ItemDetailsInitial extends ItemDetailsState {}

class ItemDetailsLoading extends ItemDetailsState {}

class ItemDetailsLoaded extends ItemDetailsState {
  final ItemDetailsModel productDetails;

  ItemDetailsLoaded({required this.productDetails});
}

class ItemDetailsError extends ItemDetailsState {
  final String error;
  ItemDetailsError(this.error);
}
