import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentora/features/item_details/data/models/item_details_model.dart';
import 'package:rentora/features/item_details/data/repos/item_details_repo.dart';

part 'item_details_state.dart';

class ItemDetailsCubit extends Cubit<ItemDetailsState> {
  final ItemDetailsRepo _itemDetailsRepo;

  ItemDetailsCubit(this._itemDetailsRepo) : super(ItemDetailsInitial());

  ItemDetailsModel? _productDetails;
  ItemDetailsModel? get productDetails => _productDetails;

  Future<void> getItemDetails(String itemId) async {
    emit(ItemDetailsLoading());

    final result = await _itemDetailsRepo.getItemDetails(itemId);

    result.fold((failure) => emit(ItemDetailsError(failure.message)), (
      details,
    ) {
      _productDetails = details;
      emit(ItemDetailsLoaded(productDetails: _productDetails!));
    });
  }
}
