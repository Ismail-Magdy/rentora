import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/features/item_details/data/models/item_details_model.dart';
import 'item_details_repo.dart';

class ItemDetailsRepoImpl implements ItemDetailsRepo {
  final FirebaseFirestore _firestore;

  ItemDetailsRepoImpl(this._firestore);

  @override
  Future<Either<Failure, ItemDetailsModel>> getItemDetails(
    String itemId,
  ) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> doc = await _firestore
          .collection('products')
          .doc(itemId)
          .get();

      if (!doc.exists || doc.data() == null) {
        return Left(ServerFailure('Product not found.'));
      }

      final Map<String, dynamic> data = Map<String, dynamic>.from(doc.data()!);
      final ownerId = data['userId'] ?? data['ownerId'];
      if (ownerId != null && ownerId.toString().isNotEmpty) {
        try {
          final userDoc = await _firestore.collection('users').doc(ownerId.toString()).get();
          if (userDoc.exists) {
            final userData = userDoc.data();
            String name = "${userData?['firstName'] ?? ''} ${userData?['lastName'] ?? ''}".trim();
            if (name.isEmpty) name = userData?['name'] ?? '';
            data['ownerName'] = name;
            data['ownerAvatar'] = userData?['profilePicture'] ?? userData?['photoUrl'] ?? userData?['photoURL'] ?? '';
            data['ownerVerificationStatus'] = userData?['verificationStatus'] ?? 'unverified';
          }
        } catch (e) {
          // ignore
        }
      }

      final ItemDetailsModel productDetails = ItemDetailsModel.fromJson(
        data,
        doc.id,
      );

      return Right(productDetails);
    } on FirebaseException catch (e) {
      return Left(
        ServerFailure(e.message ?? 'Firebase Error: Failed to fetch details'),
      );
    } catch (e) {
      return Left(
        ServerFailure('An unexpected error occurred while fetching details'),
      );
    }
  }
}
