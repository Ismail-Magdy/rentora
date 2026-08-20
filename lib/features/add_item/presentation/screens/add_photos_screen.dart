import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/features/add_item/manager/add_item_cubit.dart';
import 'package:rentora/features/add_item/manager/add_item_state.dart';
import 'package:rentora/features/add_item/presentation/widgets/add_photo_card.dart';
import 'package:rentora/features/add_item/presentation/widgets/additional_photo_card.dart';
import 'package:rentora/features/add_item/presentation/widgets/header_button.dart';
import 'package:rentora/features/add_item/presentation/widgets/main_photo_card.dart';
import 'package:rentora/features/add_item/presentation/widgets/main_photo_empty.dart';
import 'package:rentora/features/add_item/presentation/widgets/section_title.dart';

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
    return BlocBuilder<AddItemCubit, AddItemState>(
      builder: (context, state) {
        final images = state.images;
        final existingImageUrls = state.existingImageUrls;

        return Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: .symmetric(horizontal: 20.w, vertical: 12.h),
                  child: Row(
                    children: [
                      HeaderButton(
                        icon: Icons.arrow_back,
                        onTap: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Add New Listing',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryColor,
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
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Photos',
                            style: TextStyle(
                              fontSize: 14.sp,

                              color: AppColors.grey.withOpacity(0.7),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Step 3 of 4',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),

                      verticalSpace(10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 6.h,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 6.h,
                                color: AppColors.grey.withOpacity(0.3),
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
                        Text(
                          'Add photos of your item',
                          style: TextStyle(
                            fontSize: 27.sp,
                            height: 1.2.h,
                            fontWeight: FontWeight.w800,
                            color: AppColors.black,
                          ),
                        ),

                        verticalSpace(8),
                        Text(
                          'Good photos help renters understand your item and increase your chances of getting booked.',
                          style: TextStyle(
                            fontSize: 14.sp,
                            height: 1.45.h,
                            color: AppColors.grey,
                          ),
                        ),

                        verticalSpace(22),
                        // // Main photo
                        const SectionTitle(title: 'Main photo', required: true),
                        // const SizedBox(height: 10),
                        images.isEmpty
                            ? MainPhotoEmpty(onTap: () => _pickImage(context))
                            : MainPhotoCard(
                                image: images[0],
                                onRemove: () => _removeImage(context, 0),
                                onEdit: () =>
                                    _pickImage(context, replaceIndex: 0),
                              ),
                        verticalSpace(25),
                        // Additional photos
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SectionTitle(title: 'Additional photos'),
                            Text(
                              '${images.length}/$maxImages',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppColors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        verticalSpace(5),
                        Text(
                          'Add more photos from different angles.',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.grey,
                          ),
                        ),

                        verticalSpace(12),
                        _buildAdditionalPhotos(context),
                        verticalSpace(20),
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
                              Icon(
                                Icons.tips_and_updates_outlined,
                                color: AppColors.primaryColor,
                                size: 21.sp,
                              ),

                              horizontalSpace(10),
                              Expanded(
                                child: Text(
                                  'Tip: Use clear photos in good lighting and show the item from different angles.',
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 12.sp,
                                    height: 1.4.h,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Show existing remote images if in edit mode
                        if (existingImageUrls.isNotEmpty) ...[
                          verticalSpace(20),
                          const SectionTitle(title: 'Existing photos'),
                          verticalSpace(10),
                          SizedBox(
                            height: 100,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: existingImageUrls.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 10),
                              itemBuilder: (ctx, index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    existingImageUrls[index],
                                    width: 100.w,
                                    height: 100.h,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          horizontalSpace(8),
                          Icon(Icons.arrow_forward_rounded),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //
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

    final cubit = context.read<AddItemCubit>();
    if (replaceIndex != null) {
      cubit.replaceImage(replaceIndex, image);
    } else {
      if (cubit.state.images.length < maxImages) {
        cubit.addImage(image);
      } else {
        showFeedbackDialog(
          context,
          icon: Icons.photo_library_outlined,
          color: AppColors.warning,
          title: 'Maximum Photos Reached.',
          message: 'The maximum number of photos has been reached.',
        );
      }
    }
  }

  void _removeImage(BuildContext context, int index) {
    context.read<AddItemCubit>().removeImage(index);
  }

  void _onContinue(BuildContext context) {
    final listingCubit = context.read<AddItemCubit>();
    final state = listingCubit.state;

    if (state.images.isEmpty && state.existingImageUrls.isEmpty) {
      showFeedbackDialog(
        context,
        icon: Icons.photo_library_outlined,
        color: AppColors.warning,
        title: 'No Photos Added',
        message: 'Please add at least one photo.',
      );
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('Please add at least one photo'),
      //   ),
      // );
      return;
    }

    Navigator.pushNamed(
      context,
      Routes.reviewScreen,
      arguments: context.read<AddItemCubit>(),
    );
  }

  Widget _buildAdditionalPhotos(BuildContext context) {
    final images = context.watch<AddItemCubit>().state.images;
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
      items.add(AddPhotoCard(onTap: () => _pickImage(context)));
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
// 388