import 'package:dartz/dartz.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/features/item_details/data/models/item_details_model.dart';
import 'package:rentora/features/item_details/data/repos/item_details_repo.dart';

class ItemDetailsRepoImpl implements ItemDetailsRepo {
  @override
  Future<Either<Failure, ItemDetailsModel>> getItemDetails(
    String itemId,
  ) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      final dummyDetails = ItemDetailsModel(
        id: itemId,
        name: 'Canon EOS 250D',
        price: 450,
        rating: 4.8,
        reviewsCount: 120,
        distance: 2.1,
        locationName: 'Maadi, Cairo',
        imageUrls: [
          'https://dummyimage.com/1000x800/eeeeee/000000.png&text=Canon+EOS+250D+Front',
          'https://dummyimage.com/1000x800/dddddd/000000.png&text=Canon+EOS+250D+Back',
        ],
        description:
            'Canon EOS 250D is a compact and lightweight DSLR camera, perfect for photography and video. It offers great image quality and is easy to use, making it a good choice for beginners and everyday shooting.',
        keyFeatures: ['4K Video', '24.1 MP', 'Wi-Fi', 'Touch Screen'],
        ownerId: 'owner_123',
        ownerName: 'Ahmed mohamed',
        ownerAvatar:
            'https://ui-avatars.com/api/?name=Ahmed+Mohamed&background=random',
        ownerRating: 4.9,
        isSuperHost: true,
        bookedDates: [
          DateTime.now().add(const Duration(days: 2)),
          DateTime.now().add(const Duration(days: 3)),
          DateTime.now().add(const Duration(days: 5)),
        ],
        isFavorite: false,
      );

      return Right(dummyDetails);
    } catch (e) {
      return Left(
        ServerFailure('An unexpected error occurred while fetching details.'),
      );
    }
  }
}
