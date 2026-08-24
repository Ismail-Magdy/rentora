import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';
import 'package:rentora/core/widgets/custom_button.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/features/add_item/manager/add_item_cubit.dart';
import 'package:rentora/features/add_item/manager/add_item_state.dart';
import 'package:rentora/features/add_item/presentation/components/add_item_progress_bar.dart';
import 'package:rentora/features/add_item/presentation/widgets/add_photo_card.dart';
import 'package:rentora/features/add_item/presentation/widgets/additional_photo_card.dart';
import 'package:rentora/features/add_item/presentation/widgets/section_title.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

class AddPhotosScreen extends StatefulWidget {
  const AddPhotosScreen({super.key});

  @override
  State<AddPhotosScreen> createState() => _AddPhotosScreenState();
}

class _AddPhotosScreenState extends State<AddPhotosScreen> {
  final ImagePicker _picker = ImagePicker();
  static const int maxImages = 5;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddItemCubit, AddItemState>(
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;
        final images = state.images;
        final existingImageUrls = state.existingImageUrls;
        final isDark = Theme.of(context).brightness == .dark;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                // Header
                CustomAppBar(text: l10n.addNewListing),
                // Progress
                AddItemProgressBar(
                  title: l10n.photos,
                  stepNumber: l10n.stepOf("5", "7"),
                ),
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: .fromLTRB(20.w, 25.h, 20.w, 20.h),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          l10n.addPhotosTitle,
                          style: TextStyle(
                            fontSize: 27.sp,
                            height: 1.2.h,
                            fontWeight: .w800,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.black,
                          ),
                        ),

                        verticalSpace(8),
                        Text(
                          l10n.addPhotosDesc,
                          style: TextStyle(
                            fontSize: 14.sp,
                            height: 1.45.h,
                            color: AppColors.grey,
                          ),
                        ),

                        verticalSpace(22),
                        // // Main photo
                        SectionTitle(title: l10n.mainPhoto, required: true),
                        verticalSpace(10),
                        if (state.mainPhoto != null)
                          Container(
                            height: 200.h,
                            width: .infinity,
                            decoration: BoxDecoration(
                              borderRadius: .circular(24),
                              border: .all(
                                color: AppColors.primaryColor.withValues(
                                  alpha: 0.2,
                                ),
                                width: 2,
                              ),
                              image: DecorationImage(
                                image: FileImage(File(state.mainPhoto!.path)),
                                fit: .cover,
                              ),
                            ),
                          ),
                        verticalSpace(25),
                        // Additional photos
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            SectionTitle(title: l10n.additionalPhotos),
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
                          l10n.addMorePhotosAngles,
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
                            color: AppColors.primaryColor.withValues(
                              alpha: .06,
                            ),
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Row(
                            crossAxisAlignment: .start,
                            children: [
                              Icon(
                                Icons.tips_and_updates_outlined,
                                color: AppColors.primaryColor,
                                size: 21.sp,
                              ),

                              horizontalSpace(10),
                              Expanded(
                                child: Text(
                                  l10n.photoTip,
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
                          SectionTitle(title: l10n.existingPhotos),
                          verticalSpace(10),
                          SizedBox(
                            height: 100,
                            child: ListView.separated(
                              scrollDirection: .horizontal,
                              itemCount: existingImageUrls.length,
                              separatorBuilder: (_, _) =>
                                  const SizedBox(width: 10),
                              itemBuilder: (ctx, index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    existingImageUrls[index],
                                    width: 100.w,
                                    height: 100.h,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, _, _) => Container(
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
                  padding: .fromLTRB(20.w, 8.h, 20.w, 20.h),
                  child: CustomButton(
                    text: l10n.continueButton,
                    onPressed: () => _onContinue(context),
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

  //  Image Picker Methods
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
          title: 'Maximum Photos Reached',
          message: 'The maximum number of photos has been reached',
        );
      }
    }
  }

  void _removeImage(BuildContext context, int index) {
    context.read<AddItemCubit>().removeImage(index);
  }

  void _onContinue(BuildContext context) {
    Navigator.pushNamed(
      context,
      Routes.addItemAvailabilityScreen,
      arguments: context.read<AddItemCubit>(),
    );
  }

  Widget _buildAdditionalPhotos(BuildContext context) {
    final images = context.watch<AddItemCubit>().state.images;
    final List<Widget> items = [];

    // Additional images
    for (int i = 0; i < images.length; i++) {
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
