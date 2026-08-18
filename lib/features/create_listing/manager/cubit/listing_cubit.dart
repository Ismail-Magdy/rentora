import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:rentora/core/di/dependency_injection.dart';
// import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/features/create_listing/data/models/listing_entity.dart';
import 'package:rentora/features/create_listing/data/repos/listing_repository_impl.dart';
import 'package:rentora/features/create_listing/manager/cubit/listing_state.dart';

class ListingCubit extends Cubit<ListingState> {
  final  ListingRepositoryImpl _repository;
  final FirebaseAuth _auth;

  ListingCubit(this._repository, this._auth) : super(const ListingState());

  // ========== Field Updates ==========
  void updateCategory(String categoryId) =>
      emit(state.copyWith(categoryId: categoryId));

  void updateTitle(String title) =>
      emit(state.copyWith(title: title));

  void updateDescription(String description) =>
      emit(state.copyWith(description: description));

  void updateCondition(String condition) =>
      emit(state.copyWith(condition: condition));

  void updateDailyPrice(double price) =>
      emit(state.copyWith(dailyPrice: price));

  void updateSecurityDeposit(double deposit) =>
      emit(state.copyWith(securityDeposit: deposit));

  void updateLocation(String location) =>
      emit(state.copyWith(location: location));

  // ========== Image Management ==========
  void addImage(XFile image) {
    final newList = List<XFile>.from(state.images)..add(image);
    emit(state.copyWith(images: newList));
  }

  void removeImage(int index) {
    if (state.images.length <= 1) return; // Keep at least one local image
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

  // ========== Load for Edit ==========
  Future<void> loadListingForEdit(String listingId) async {
    emit(state.copyWith(status: ListingStatus.loading, errorMessage: null));
    try {
      final listing = await _repository.fetchListing(listingId);
      emit(state.copyWith(
        categoryId: listing.category,
        title: listing.title,
        description: listing.description,
        condition: listing.condition,
        dailyPrice: listing.dailyPrice,
        securityDeposit: listing.securityDeposit,
        location: listing.location,
        existingImageUrls: listing.imageUrls,
        isEditMode: true,
        listingId: listing.id,
        images: [], // no new local images initially
        status: ListingStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ListingStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  // ========== Publish / Save ==========
  Future<void> publishListing() async {
    // Validate
    final validationError = state.getValidationError();
    if (validationError != null) {
      emit(state.copyWith(
        status: ListingStatus.error,
        errorMessage: validationError,
      ));
      return;
    }

    emit(state.copyWith(status: ListingStatus.loading, errorMessage: null));

    try {
      final currentUser =_auth.currentUser;
      if (currentUser == null) {
        throw Exception('User not authenticated');
      }

      // Build ListingEntity
      final listing = ListingEntity(
        id: state.listingId ?? '',
        userId: currentUser.uid,
        category: state.categoryId,
        title: state.title,
        description: state.description,
        condition: state.condition,
        dailyPrice: state.dailyPrice,
        securityDeposit: state.securityDeposit,
        location: state.location,
        imageUrls: state.existingImageUrls, // will be updated by repository
        createdAt: DateTime.now(),
        isAvailable: true,
      );

      // Save via repository
      await _repository.saveListing(
        listing: listing,
        newImages: state.images.isNotEmpty ? state.images : null,
        existingImageUrls: state.existingImageUrls,
      );

      emit(state.copyWith(
        status: ListingStatus.success,
        isPublished: true,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ListingStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  // ========== Reset ==========
  void reset() {
    emit(const ListingState());
  }
}