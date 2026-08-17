import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/create_listing/manager/cubit/listing_cubit.dart';
import 'package:rentora/features/create_listing/manager/cubit/listing_state.dart';
import 'package:rentora/features/create_listing/presentation/screens/review_publish_screen.dart';
import 'package:rentora/features/create_listing/presentation/widgets/add_photo_card.dart';
import 'package:rentora/features/create_listing/presentation/widgets/additional_photo_card.dart';
import 'package:rentora/features/create_listing/presentation/widgets/header_button.dart';
import 'package:rentora/features/create_listing/presentation/widgets/main_photo_card.dart';
import 'package:rentora/features/create_listing/presentation/widgets/main_photo_empty.dart';
import 'package:rentora/features/create_listing/presentation/widgets/section_title.dart';

class AddPhotosScreen extends StatefulWidget {
  const AddPhotosScreen({super.key});

  @override
  State<AddPhotosScreen> createState() => _AddPhotosScreenState();
}

class _AddPhotosScreenState extends State<AddPhotosScreen> {
  final ImagePicker _picker = ImagePicker();
  static const int maxImages = 6;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListingCubit, ListingState>(
      builder: (context, state) {
        final images = state.images;
        final existingImageUrls = state.existingImageUrls;

        // For edit mode, we display existing images as well.
        // But we can't directly display remote URLs as XFile.
        // We'll show them as network images alongside local ones.
        // We'll manage a combined list for display.
        // For simplicity, we'll just show local images and rely on the review screen to show both.
        // But the user should be able to add/remove local images.
        // We'll keep the current logic: only manage local images.

        return Scaffold(
          backgroundColor: const Color(0xFFF9FAFA),
          body: SafeArea(
            child: Column(
              children: [
                // Header (unchanged)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    children: [
                      HeaderButton(
                        icon: Icons.arrow_back,
                        onTap: () => Navigator.pop(context),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Add New Listing',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF171717),
                            ),
                          ),
                        ),
                      ),
                      HeaderButton(
                        icon: Icons.close,
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                // Progress (unchanged)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Photos',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6D7478),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Step 3 of 4',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 6,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 6,
                                color: const Color(0xFFE5E8E9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Add photos of your item',
                          style: TextStyle(
                            fontSize: 27,
                            height: 1.2,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF171717),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Good photos help renters understand your item and increase your chances of getting booked.',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.45,
                            color: Color(0xFF6D7478),
                          ),
                        ),
                        const SizedBox(height: 22),
                        // Main photo
                        const SectionTitle(
                          title: 'Main photo',
                          required: true,
                        ),
                        const SizedBox(height: 10),
                        images.isEmpty
                            ? MainPhotoEmpty(
                                onTap: () => _pickImage(context),
                              )
                            : MainPhotoCard(
                                image: images[0],
                                onRemove: () => _removeImage(context, 0),
                                onEdit: () => _pickImage(context, replaceIndex: 0),
                              ),
                        const SizedBox(height: 25),
                        // Additional photos
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SectionTitle(
                              title: 'Additional photos',
                            ),
                            Text(
                              '${images.length}/$maxImages',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF7A8184),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Add more photos from different angles.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF7A8184),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildAdditionalPhotos(context),
                        const SizedBox(height: 20),
                        // Tip
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(.06),
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.tips_and_updates_outlined,
                                color: AppColors.primaryColor,
                                size: 21,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Tip: Use clear photos in good lighting and show the item from different angles.',
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 12,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Show existing remote images if in edit mode
                        if (existingImageUrls.isNotEmpty) ...[
                          const SizedBox(height: 20),
                          const SectionTitle(title: 'Existing photos'),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 100,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: existingImageUrls.length,
                              separatorBuilder: (_, __) => const SizedBox(width: 10),
                              itemBuilder: (ctx, index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    existingImageUrls[index],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      color: Colors.grey[300],
                                      child: const Icon(Icons.broken_image),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                // Continue button
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => _onContinue(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_rounded,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ========== Image Picker Methods ==========
  Future<void> _pickImage(BuildContext context, {int? replaceIndex}) async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (image == null) return;

    final cubit = context.read<ListingCubit>();
    if (replaceIndex != null) {
      cubit.replaceImage(replaceIndex, image);
    } else {
      if (cubit.state.images.length < maxImages) {
        cubit.addImage(image);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Maximum 6 photos allowed')),
        );
      }
    }
  }

  void _removeImage(BuildContext context, int index) {
    context.read<ListingCubit>().removeImage(index);
  }

void _onContinue(BuildContext context) {
  final listingCubit = context.read<ListingCubit>();
  final state = listingCubit.state;

  if (state.images.isEmpty && state.existingImageUrls.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please add at least one photo'),
      ),
    );
    return;
  }

Navigator.pushNamed(
  context,
  Routes.reviewScreen,
);
}

  Widget _buildAdditionalPhotos(BuildContext context) {
    final images = context.watch<ListingCubit>().state.images;
    final List<Widget> items = [];

    // Existing additional images (skip index 0)
    for (int i = 1; i < images.length; i++) {
      items.add(
        AdditionalPhotoCard(
          image: images[i],
          onRemove: () => _removeImage(context, i),
          onEdit: () => _pickImage(context, replaceIndex: i),
        ),
      );
    }

    // Add button
    if (images.length < maxImages) {
      items.add(
        AddPhotoCard(
          onTap: () => _pickImage(context),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return items[index];
      },
    );
  }
}