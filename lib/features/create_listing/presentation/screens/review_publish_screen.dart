import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/features/create_listing/manager/listing_cubit.dart';
import 'package:rentora/features/create_listing/manager/listing_state.dart';
import 'package:rentora/features/create_listing/presentation/widgets/add_photo_button.dart';
import 'package:rentora/features/create_listing/presentation/widgets/description_row.dart';
import 'package:rentora/features/create_listing/presentation/widgets/header_button.dart';
import 'package:rentora/features/create_listing/presentation/widgets/info_row.dart';
import 'package:rentora/features/create_listing/presentation/widgets/price_row.dart';
import 'package:rentora/features/create_listing/presentation/widgets/review_card.dart';
import 'package:rentora/features/create_listing/presentation/widgets/section_header.dart';

class ReviewAndPublishScreen extends StatefulWidget {
  const ReviewAndPublishScreen({super.key});

  @override
  State<ReviewAndPublishScreen> createState() => _ReviewAndPublishScreenState();
}

class _ReviewAndPublishScreenState extends State<ReviewAndPublishScreen> {
  bool _isConfirmed = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListingCubit, ListingState>(
      listener: (context, state) {
        if (state.status == ListingStatus.error) {
          showFeedbackDialog(
            context,
            icon: Icons.error_outline,
            color: AppColors.error,
            title: 'Something Went Wrong',
            message: state.errorMessage ?? 'An error occurred.',
          );
        }
        if (state.isPublished) {
          _showSuccessDialog(context);
        }
      },
      builder: (context, state) {
        final isPublishing = state.status == ListingStatus.loading;

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFA),
          body: SafeArea(
            child: Column(
              children: [
                // Header (unchanged)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                  child: Row(
                    children: [
                      HeaderButton(
                        icon: Icons.close_rounded,
                        onTap: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Add New Listing',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      HeaderButton(
                        icon: Icons.help_outline_rounded,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                // Progress (full)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Review & Publish',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Color(0xFF6D7478),
                            ),
                          ),
                          Text(
                            'Step 4 of 4',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 9),
                      Row(
                        children: List.generate(
                          4,
                          (index) => Expanded(
                            child: Container(
                              margin: EdgeInsets.only(
                                right: index == 3 ? 0 : 5,
                              ),
                              height: 6.h,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 25, 20, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Review your listing',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF171717),
                          ),
                        ),
                        verticalSpace(7),
                        Text(
                          'Make sure everything looks good before publishing.',
                          style: TextStyle(
                            fontSize: 14.sp,
                            height: 1.4.h,
                            color: Color(0xFF6D7478),
                          ),
                        ),
                        verticalSpace(24),
                        // Photos
                        SectionHeader(
                          title: 'Photos',
                          onEdit: () {
                            Navigator.pop(context); // go back to photos
                          },
                        ),
                        verticalSpace(12),
                        _buildPhotos(state),
                        verticalSpace(24),
                        // Item Details
                        ReviewCard(
                          title: 'Item Details',
                          icon: Icons.inventory_2_outlined,
                          onEdit: () {
                            Navigator.pop(context); // go back to details
                          },
                          child: Column(
                            children: [
                              InfoRow(
                                label: 'Category',
                                value: state.categoryId,
                              ),
                              Divider(height: 24.h),
                              InfoRow(
                                label: 'Title',
                                value: state.title,
                                valueBold: true,
                              ),
                              Divider(height: 24.h),
                              DescriptionRow(description: state.description),
                              Divider(height: 24.h),
                              InfoRow(
                                label: 'Condition',
                                value: state.condition,
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(16.h),
                        // AI suggestion (placeholder)
                        _buildAiSuggestion(),
                        verticalSpace(16.h),
                        // Rental Details
                        ReviewCard(
                          title: 'Rental Details',
                          icon: Icons.payments_outlined,
                          onEdit: () {
                            Navigator.pop(context);
                          },
                          child: Column(
                            children: [
                              PriceRow(
                                label: 'Daily rental price',
                                value:
                                    'EGP ${state.dailyPrice.toStringAsFixed(0)}',
                                highlighted: true,
                              ),
                              const Divider(height: 24),
                              PriceRow(
                                label: 'Security deposit',
                                value:
                                    'EGP ${state.securityDeposit.toStringAsFixed(0)}',
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(16.h),
                        // Location
                        ReviewCard(
                          title: 'Location',
                          icon: Icons.location_on_outlined,
                          onEdit: () {
                            // TODO: navigate to location picker
                          },
                          child: Row(
                            children: [
                              Container(
                                width: 42.w,
                                height: 42.h,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor.withOpacity(
                                    .08,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.location_on_outlined,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              horizontalSpace(12),
                              Expanded(
                                child: Text(
                                  state.location.isNotEmpty
                                      ? state.location
                                      : 'No location set',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(20),
                        // Confirmation checkbox
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isConfirmed = !_isConfirmed;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: _isConfirmed
                                  ? AppColors.success.withOpacity(.07)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(17),
                              border: Border.all(
                                color: _isConfirmed
                                    ? AppColors.success
                                    : const Color(0xFFE3E7E8),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 180),
                                  width: 24.w,
                                  height: 24.h,
                                  decoration: BoxDecoration(
                                    color: _isConfirmed
                                        ? AppColors.success
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: _isConfirmed
                                          ? AppColors.success
                                          : const Color(0xFFBFC7C9),
                                      width: 1.5.w,
                                    ),
                                  ),
                                  child: _isConfirmed
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 17,
                                        )
                                      : null,
                                ),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Text(
                                    'I confirm that all information provided is accurate and that I have the right to rent out this item.',
                                    style: TextStyle(
                                      fontSize: 13,
                                      height: 1.5,
                                      color: Color(0xFF555D60),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Publish button
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFA),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.04),
                        blurRadius: 12,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: _isConfirmed && !isPublishing
                          ? () => _publishListing(context)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        disabledBackgroundColor: AppColors.primaryColor
                            .withOpacity(.6),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: isPublishing
                          ? const SizedBox(
                              width: 23,
                              height: 23,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Publish Listing',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                horizontalSpace(12),
                                Icon(Icons.arrow_upward_rounded),
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

  void _publishListing(BuildContext context) {
    context.read<ListingCubit>().publishListing();
  }

  void _showSuccessDialog(BuildContext context) {
    final cubit = context.read<ListingCubit>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72.w,
                height: 72.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.success.withOpacity(.12),
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: AppColors.success,
                  size: 42,
                ),
              ),
              // const SizedBox(height: 20),
              verticalSpace(20),
              Text(
                'Listing Published!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w800),
              ),
              verticalSpace(10),
              Text(
                'Your item is now available for renters to discover.',
                textAlign: TextAlign.center,
                style: TextStyle(height: 1.5.h, color: Color(0xFF6D7478)),
              ),
              verticalSpace(24),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    cubit.reset();

                    Navigator.pop(dialogContext);

                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPhotos(ListingState state) {
    // ignore: unused_local_variable
    final allImages = [
      ...state.images,
      ...state.existingImageUrls.map((url) => url),
    ]; // not ideal but for display
    // Actually we want to show local images and remote images separately.
    // We'll show local images as file previews, and remote as network.
    // We'll construct a list of widgets.
    List<Widget> widgets = [];

    // Local images
    for (var image in state.images) {
      widgets.add(
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.file(
            File(image.path),
            width: 105.w,
            height: 105.h,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    // Remote images
    for (var url in state.existingImageUrls) {
      widgets.add(
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            url,
            width: 105.w,
            height: 105.h,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: AppColors.grey.withOpacity(.1),
              child: const Icon(Icons.broken_image),
            ),
          ),
        ),
      );
    }

    if (widgets.isEmpty) {
      return Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.white),
        ),
        child: const Center(
          child: Text(
            'No photos added',
            style: TextStyle(color: AppColors.grey),
          ),
        ),
      );
    }

    // Add "Add" button if less than 6 total
    if (state.images.length + state.existingImageUrls.length < 6) {
      widgets.add(
        AddPhotoButton(
          onTap: () {
            Navigator.pop(context); // go back to photos
          },
        ),
      );
    }

    return SizedBox(
      height: 105.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widgets.length,
        separatorBuilder: (_, __) => horizontalSpace(10.w),
        itemBuilder: (context, index) {
          // Mark first as "Main"
          if (index == 0 && widgets.isNotEmpty) {
            return Stack(
              children: [
                widgets[index],
                Positioned(
                  left: 7,
                  bottom: 7,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Main',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return widgets[index];
        },
      ),
    );
  }

  Widget _buildAiSuggestion() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor.withOpacity(.10),
            AppColors.success.withOpacity(.06),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.primaryColor.withOpacity(.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42.w,
            height: 42.h,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: AppColors.white,
              size: 21,
            ),
          ),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI-assisted listing',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryColor,
                  ),
                ),
                verticalSpace(5),
                Text(
                  'Some listing details were suggested by AI based on your item photo. You can edit them before publishing.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.45,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
