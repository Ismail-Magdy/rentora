import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/core/errors/firebase_error_handler.dart';
import 'package:rentora/core/helpers/constants.dart';
import 'package:rentora/core/network/firebase/cloudinary_service.dart';
import 'package:rentora/features/create_listing/data/models/listing_model.dart';

class ListingRepositoryImpl {
  final CloudinaryService _cloudinaryService;
  final FirebaseFirestore _firestore;

  ListingRepositoryImpl(this._firestore, this._cloudinaryService);

  Future<ListingModel> fetchListing(String listingId) async {
    try {
      final doc = await _firestore
          .collection(AppConstants.listingsCollection)
          .doc(listingId)
          .get();
      if (!doc.exists) throw ServerFailure('Listing not found');
      return ListingModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    } catch (e) {
      throw ServerFailure(FirebaseErrorHandler.handle(e));
    }
  }

  Future<void> saveListing({
    required ListingModel listing,
    List<XFile>? newImages,
    List<String>? existingImageUrls,
  }) async {
    try {
      List<String> finalImageUrls = existingImageUrls ?? [];

      // Upload new images if any
      if (newImages != null && newImages.isNotEmpty) {
        final uploadedUrls = await _cloudinaryService.uploadMultipleImages(
          newImages,
        );
        finalImageUrls.addAll(uploadedUrls);
      }

      // Build the final map
      final data = listing.toMap()
        ..['imageUrls'] = finalImageUrls
        ..['updatedAt'] = DateTime.now().toIso8601String();

      if (listing.id.isEmpty) {
        // New listing
        await _firestore.collection('listings').add(data);
      } else {
        // Update existing
        await _firestore.collection('listings').doc(listing.id).update(data);
      }
    } catch (e) {
      throw ServerFailure(FirebaseErrorHandler.handle(e));
    }
  }
}
