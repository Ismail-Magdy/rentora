import 'package:dartz/dartz.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/features/item_details/data/models/item_details_model.dart';

abstract class ItemDetailsRepo {
  Future<Either<Failure, ItemDetailsModel>> getItemDetails(String itemId);

  // TODO
  // Future<Either<Failure, void>> toggleFavorite(String itemId);
}
