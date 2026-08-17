import 'package:rentora/features/create_listing/data/models/listing_entity.dart';
import 'package:image_picker/image_picker.dart';

abstract class ListingRepository {
  /// Fetch a single listing by ID
  Future<ListingEntity> fetchListing(String listingId);

  /// Save a new listing or update an existing one.
  /// - [listing] is the entity to save (id may be empty for new).
  /// - [newImages] are newly selected local images to upload.
  /// - [existingImageUrls] are the URLs of existing images to keep (if editing).
  /// The repository will combine them and upload new ones.
  Future<void> saveListing({
    required ListingEntity listing,
    List<XFile>? newImages,
    List<String>? existingImageUrls,
  });
}