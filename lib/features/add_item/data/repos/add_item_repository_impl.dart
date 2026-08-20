import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/core/errors/firebase_error_handler.dart';
import 'package:rentora/core/helpers/constants.dart';
import 'package:rentora/core/network/firebase/cloudinary_service.dart';
import 'package:rentora/features/add_item/data/models/add_item_model.dart';

class AddItemRepositoryImpl {
  final CloudinaryService _cloudinaryService;
  final FirebaseFirestore _firestore;

  AddItemRepositoryImpl(this._firestore, this._cloudinaryService);

  Future<AddItemModel> fetchListing(String listingId) async {
    try {
      final doc = await _firestore
          .collection(AppConstants.listingsCollection)
          .doc(listingId)
          .get();
      if (!doc.exists) throw ServerFailure('Listing not found');
      return AddItemModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    } catch (e) {
      throw ServerFailure(FirebaseErrorHandler.handle(e));
    }
  }

  Future<void> saveListing({
    required AddItemModel listing,
    List<XFile>? newImages,
    List<String>? existingImageUrls,
  }) async {
    try {
      List<String> finalImageUrls = List.from(existingImageUrls ?? []);

      if (newImages != null && newImages.isNotEmpty) {
        final uploadTasks = newImages.map((xFile) {
          return _cloudinaryService.uploadImage(File(xFile.path));
        }).toList();

        final uploadedUrls = await Future.wait(uploadTasks);

        finalImageUrls.addAll(uploadedUrls.whereType<String>());
      }

      // Build the final map
      final data = listing.toMap()
        ..['imageUrls'] = finalImageUrls
        ..['updatedAt'] = DateTime.now().toIso8601String();

      if (listing.id.isEmpty) {
        await _firestore.collection('products').add(data);
      } else {
        await _firestore.collection('products').doc(listing.id).update(data);
      }
    } catch (e) {
      throw ServerFailure(FirebaseErrorHandler.handle(e));
    }
  }
}
