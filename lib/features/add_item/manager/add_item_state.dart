import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

enum AddItemStatus { initial, loading, success, error }

class AddItemState extends Equatable {
  final String categoryId;
  final String title;
  final String description;
  final String condition;
  final double dailyPrice;
  final double securityDeposit;
  final String location;

  // Images
  final XFile? mainPhoto; // Main photo captured in Step 1
  final List<XFile> images; // Additional local images
  final List<String> existingImageUrls; // Existing remote URLs (for edit)

  // Edit mode
  final bool isEditMode;
  final String? listingId; // ID of listing being edited

  // Status
  final AddItemStatus status;
  final String? errorMessage;

  // Publish result
  final bool isPublished;

  // Terms & Conditions
  final bool agreedToTerms;

  const AddItemState({
    this.categoryId = '',
    this.title = '',
    this.description = '',
    this.condition = 'Good',
    this.dailyPrice = 0,
    this.securityDeposit = 0,
    this.location = '',
    this.mainPhoto,
    this.images = const [],
    this.existingImageUrls = const [],
    this.isEditMode = false,
    this.listingId,
    this.status = AddItemStatus.initial,
    this.errorMessage,
    this.isPublished = false,
    this.agreedToTerms = false,
  });

  @override
  List<Object?> get props => [
    categoryId,
    title,
    description,
    condition,
    dailyPrice,
    securityDeposit,
    location,
    mainPhoto,
    images,
    existingImageUrls,
    isEditMode,
    listingId,
    status,
    errorMessage,
    isPublished,
    agreedToTerms,
  ];

  AddItemState copyWith({
    String? categoryId,
    String? title,
    String? description,
    String? condition,
    double? dailyPrice,
    double? securityDeposit,
    String? location,
    XFile? mainPhoto,
    bool clearMainPhoto = false,
    List<XFile>? images,
    List<String>? existingImageUrls,
    bool? isEditMode,
    String? listingId,
    AddItemStatus? status,
    String? errorMessage,
    bool? isPublished,
    bool? agreedToTerms,
  }) {
    return AddItemState(
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      description: description ?? this.description,
      condition: condition ?? this.condition,
      dailyPrice: dailyPrice ?? this.dailyPrice,
      securityDeposit: securityDeposit ?? this.securityDeposit,
      location: location ?? this.location,
      mainPhoto: clearMainPhoto ? null : (mainPhoto ?? this.mainPhoto),
      images: images ?? this.images,
      existingImageUrls: existingImageUrls ?? this.existingImageUrls,
      isEditMode: isEditMode ?? this.isEditMode,
      listingId: listingId ?? this.listingId,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isPublished: isPublished ?? this.isPublished,
      agreedToTerms: agreedToTerms ?? this.agreedToTerms,
    );
  }

  // Helper to get all image URLs (existing + newly uploaded)
  List<String> getAllImageUrls() {
    // We can't know the final URLs until upload, but this is for display
    // In review, we show existing + placeholders for new ones.
    return existingImageUrls;
  }

  // Validation
  bool get isValid {
    return categoryId.isNotEmpty &&
        title.isNotEmpty &&
        description.isNotEmpty &&
        condition.isNotEmpty &&
        dailyPrice > 0 &&
        securityDeposit >= 0 &&
        (mainPhoto != null || images.isNotEmpty || existingImageUrls.isNotEmpty);
  }

  String? getValidationError() {
    if (mainPhoto == null && images.isEmpty && existingImageUrls.isEmpty) {
      return 'Please add at least one photo';
    }
    if (categoryId.isEmpty) return 'Please select a category';
    if (title.isEmpty) return 'Please enter a title';
    if (description.isEmpty) return 'Please enter a description';
    if (condition.isEmpty) return 'Please select a condition';
    if (dailyPrice <= 0) return 'Daily price must be greater than 0';
    if (securityDeposit < 0) return 'Security deposit cannot be negative';

    return null;
  }
}
