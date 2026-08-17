import 'package:image_picker/image_picker.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/core/errors/firebase_error_handler.dart';
import 'package:rentora/core/network/firebase/cloudinary_service.dart';
import 'package:rentora/core/network/firebase/listings_firestore_service.dart';

import 'package:rentora/features/create_listing/data/datasources/listing_remote_data_source.dart';
import 'package:rentora/features/create_listing/data/models/listing_entity.dart';
import 'package:rentora/features/create_listing/manager/repositories/listing_repository.dart';

class ListingRepositoryImpl implements ListingRepository {
  final ListingRemoteDataSource _dataSource;
  final CloudinaryService _cloudinaryService;
 

  ListingRepositoryImpl(this._dataSource, this._cloudinaryService);

  @override
  Future<ListingEntity> fetchListing(String listingId) async {
    try {
      final doc = await _dataSource.getListing(listingId);
      if (!doc.exists) throw ServerFailure('Listing not found');
      return ListingEntity.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    } catch (e) {
      throw ServerFailure(FirebaseErrorHandler.handle(e));
    }
  }

  @override
  Future<void> saveListing({
    required ListingEntity listing,
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
        await _dataSource.createListing(data);
      } else {
        // Update existing
        await _dataSource.updateListing(listing.id, data);
      }
    } catch (e) {
      throw ServerFailure(FirebaseErrorHandler.handle(e));
    }
  }
}
