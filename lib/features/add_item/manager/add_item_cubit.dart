import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentora/features/add_item/data/models/add_item_model.dart';
import 'package:rentora/features/add_item/data/repos/add_item_repository_impl.dart';
import 'package:rentora/features/add_item/manager/add_item_state.dart';

class AddItemCubit extends Cubit<AddItemState> {
  final AddItemRepositoryImpl _repository;
  final FirebaseAuth _auth;

  AddItemCubit(this._repository, this._auth) : super(const AddItemState());

  // Main Photo
  void setMainPhoto(XFile photo) {
    emit(state.copyWith(mainPhoto: photo));
  }

  // Field Updates
  void updateCategory(String categoryId) =>
      emit(state.copyWith(categoryId: categoryId));

  void updateTitle(String title) => emit(state.copyWith(title: title));

  void updateDescription(String description) =>
      emit(state.copyWith(description: description));

  void updateCondition(String condition) =>
      emit(state.copyWith(condition: condition));

  void updateDailyPrice(double price) =>
      emit(state.copyWith(dailyPrice: price));

  void updateSecurityDeposit(double deposit) =>
      emit(state.copyWith(securityDeposit: deposit));

  void updateRating(double rating) =>
      emit(state.copyWith(rating: rating));

  void updateLocation(String location, GeoPoint geoPoint) =>
      emit(state.copyWith(location: location, locationGeoPoint: geoPoint));

  void updateAvailability(DateTime from, DateTime to) =>
      emit(state.copyWith(availableFrom: from, availableTo: to));

  void toggleKeyFeature(String feature) {
    final currentFeatures = List<String>.from(state.keyFeatures);
    if (currentFeatures.contains(feature)) {
      currentFeatures.remove(feature);
    } else {
      currentFeatures.add(feature);
    }
    emit(state.copyWith(keyFeatures: currentFeatures));
  }

  // Terms & Conditions
  void toggleAgreedToTerms() =>
      emit(state.copyWith(agreedToTerms: !state.agreedToTerms));

  // Image Management (Additional Photos)
  void addImage(XFile image) {
    final newList = List<XFile>.from(state.images)..add(image);
    emit(state.copyWith(images: newList));
  }

  void removeImage(int index) {
    if (index < 0 || index >= state.images.length) return;
    final newList = List<XFile>.from(state.images)..removeAt(index);
    emit(state.copyWith(images: newList));
  }

  void replaceImage(int index, XFile image) {
    final newList = List<XFile>.from(state.images)..[index] = image;
    emit(state.copyWith(images: newList));
  }

  void setImages(List<XFile> images) {
    emit(state.copyWith(images: images));
  }

  //  Load for Edit
  Future<void> loadListingForEdit(String listingId) async {
    emit(state.copyWith(status: .loading, errorMessage: null));
    try {
      final listing = await _repository.fetchListing(listingId);
      emit(
        state.copyWith(
          categoryId: listing.category,
          title: listing.title,
          description: listing.description,
          condition: listing.condition,
          dailyPrice: listing.dailyPrice,
          securityDeposit: listing.securityDeposit,
          location: listing.location,
          locationGeoPoint: listing.locationGeoPoint,
          rating: listing.rating,
          keyFeatures: listing.keyFeatures,
          availableFrom: listing.availableFrom,
          availableTo: listing.availableTo,
          existingImageUrls: listing.imageUrls,
          isEditMode: true,
          listingId: listing.id,
          images: [], // no new local images initially
          status: AddItemStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AddItemStatus.error, errorMessage: e.toString()),
      );
    }
  }

  //  Publish / Save
  Future<void> publishListing() async {
    // Validate
    final validationError = state.getValidationError();
    if (validationError != null) {
      emit(state.copyWith(status: .error, errorMessage: validationError));
      return;
    }

    emit(state.copyWith(status: AddItemStatus.loading, errorMessage: null));

    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('User not authenticated');
      }

      // Build the full images list: mainPhoto first, then additional
      final allImages = <XFile>[];
      if (state.mainPhoto != null) {
        allImages.add(state.mainPhoto!);
      }
      allImages.addAll(state.images);

      // Build ListingEntity
      final listing = AddItemModel(
        id: state.listingId ?? '',
        userId: currentUser.uid,
        category: state.categoryId,
        title: state.title,
        description: state.description,
        condition: state.condition,
        dailyPrice: state.dailyPrice,
        securityDeposit: state.securityDeposit,
        location: state.location,
        locationGeoPoint: state.locationGeoPoint,
        rating: state.rating,
        keyFeatures: state.keyFeatures,
        availableFrom: state.availableFrom,
        availableTo: state.availableTo,
        imageUrls: state.existingImageUrls, // will be updated by repository
        createdAt: DateTime.now(),
        isAvailable: true,
      );

      // Save via repository
      await _repository.saveListing(
        listing: listing,
        newImages: allImages.isNotEmpty ? allImages : null,
        existingImageUrls: state.existingImageUrls,
      );

      emit(
        state.copyWith(
          status: AddItemStatus.success,
          isPublished: true,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AddItemStatus.error, errorMessage: e.toString()),
      );
    }
  }

  //  Reset
  void reset() {
    emit(const AddItemState());
  }
}
