import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/add_item/manager/add_item_cubit.dart';
import 'package:rentora/features/add_item/manager/add_item_state.dart';
import 'package:rentora/features/add_item/presentation/widgets/add_photo_button.dart';
import 'package:rentora/features/add_item/presentation/widgets/description_row.dart';
import 'package:rentora/features/add_item/presentation/widgets/info_row.dart';
import 'package:rentora/features/add_item/presentation/widgets/price_row.dart';
import 'package:rentora/features/add_item/presentation/widgets/review_card.dart';
import 'package:rentora/features/add_item/presentation/widgets/section_header.dart';

class ReviewPublishScreenContent extends StatefulWidget {
  const ReviewPublishScreenContent({
    super.key,
    required this.reviewListing,
    required this.isDark,
    required this.reviewListingDesc,
    required this.photos,
    required this.itemDetails,
    required this.category,
    required this.itemName,
    required this.condition,
    required this.availability,
    required this.formatDateAvailableFrom,
    required this.formatDateAvailableTo,
    required this.rentalDetails,
    required this.dailyPrice,
    required this.sar,
    required this.securityDepositLabel,
    required this.location,
    required this.isLoadingLocation,
    required this.onTap,
    required this.state,
  });

  final bool isDark;

  final String reviewListing;
  final String reviewListingDesc;
  final String photos;
  final String itemDetails;
  final String category;
  final String itemName;
  final String condition;
  final String availability;
  final String formatDateAvailableFrom;
  final String formatDateAvailableTo;
  final String rentalDetails;
  final String dailyPrice;
  final String sar;
  final String securityDepositLabel;
  final String location;
  //
  final bool isLoadingLocation;
  //
  final Function() onTap;

  //
  final AddItemState state;

  @override
  State<ReviewPublishScreenContent> createState() =>
      _ReviewPublishScreenContentState();
}

class _ReviewPublishScreenContentState
    extends State<ReviewPublishScreenContent> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: .fromLTRB(20.w, 25.h, 20.w, 30.h),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              widget.reviewListing,
              style: TextStyle(
                fontSize: 28,
                fontWeight: .w800,
                color: widget.isDark
                    ? AppColors.darkTextPrimary
                    : const Color(0xFF171717),
              ),
            ),
            verticalSpace(7),
            Text(
              widget.reviewListingDesc,
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.4.h,
                color: AppColors.grey,
              ),
            ),
            verticalSpace(24),
            // Photos
            SectionHeader(
              title: widget.photos,
              onEdit: () => context.pushNamed(
                Routes.addPhotosScreen,
                arguments: context.read<AddItemCubit>(),
              ),
            ),
            verticalSpace(12),
            _buildPhotos(widget.state),
            verticalSpace(24),
            // Item Details
            ReviewCard(
              title: widget.itemDetails,
              icon: Icons.inventory_2_outlined,
              onEdit: () => context.pushNamed(
                Routes.addItemDetailsScreen,
                arguments: context.read<AddItemCubit>(),
              ),

              child: Column(
                children: [
                  InfoRow(
                    label: widget.category,
                    value: widget.state.categoryId,
                  ),
                  Divider(height: 24.h),
                  InfoRow(
                    label: widget.itemName,
                    value: widget.state.title,
                    valueBold: true,
                  ),
                  Divider(height: 24.h),
                  DescriptionRow(description: widget.state.description),
                  Divider(height: 24.h),
                  InfoRow(
                    label: widget.condition,
                    value: widget.state.condition,
                  ),
                ],
              ),
            ),
            // AI suggestion (placeholder)
            verticalSpace(16.h),
            // Availability
            ReviewCard(
              title: widget.availability,
              icon: Icons.calendar_today_outlined,
              onEdit: () => context.pushNamed(
                Routes.addItemAvailabilityScreen,
                arguments: context.read<AddItemCubit>(),
              ),

              child: Column(
                children: [
                  InfoRow(label: "From", value: widget.formatDateAvailableFrom),
                  Divider(height: 24.h),
                  InfoRow(label: 'To', value: widget.formatDateAvailableTo),
                ],
              ),
            ),
            verticalSpace(16.h),
            // Rental Details
            ReviewCard(
              title: widget.rentalDetails,
              icon: Icons.payments_outlined,
              onEdit: () {
                Navigator.pop(context);
              },
              child: Column(
                children: [
                  PriceRow(
                    label: widget.dailyPrice,
                    value:
                        '${widget.state.dailyPrice.toStringAsFixed(0)} ${widget.sar}',
                    highlighted: true,
                  ),
                  const Divider(height: 24),
                  PriceRow(
                    label: widget.securityDepositLabel,
                    value:
                        '${widget.state.securityDeposit.toStringAsFixed(0)} ${widget.sar}',
                  ),
                ],
              ),
            ),
            verticalSpace(16.h),
            // Location
            ReviewCard(
              title: widget.location,
              icon: Icons.location_on_outlined,
              child: Row(
                children: [
                  Container(
                    width: 42.w,
                    height: 42.h,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.my_location,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  horizontalSpace(12),
                  Expanded(
                    child: widget.state.location.isNotEmpty
                        ? Text(
                            widget.state.location,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : widget.isLoadingLocation
                        ? Row(
                            children: [
                              const CupertinoActivityIndicator(radius: 10),
                              horizontalSpace(6),
                              const Text(
                                'Fetching location',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: .w600,
                                  color: AppColors.grey,
                                ),
                              ),
                            ],
                          )
                        : GestureDetector(
                            onTap: widget.onTap,
                            child: const Text(
                              'Use current location',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
            verticalSpace(20),
            // Confirmation checkbox
            GestureDetector(
              onTap: () => context.read<AddItemCubit>().toggleAgreedToTerms(),

              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: widget.state.agreedToTerms
                      ? AppColors.success.withValues(alpha: .07)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(
                    color: widget.state.agreedToTerms
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
                        color: widget.state.agreedToTerms
                            ? AppColors.success
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: widget.state.agreedToTerms
                              ? AppColors.success
                              : const Color(0xFFBFC7C9),
                          width: 1.5.w,
                        ),
                      ),
                      child: widget.state.agreedToTerms
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
    );
  }

  Widget _buildPhotos(AddItemState state) {
    List<Widget> widgets = [];

    // Main photo
    if (state.mainPhoto != null) {
      widgets.add(
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.file(
            File(state.mainPhoto!.path),
            width: 105.w,
            height: 105.h,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

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
            errorBuilder: (_, _, _) => Container(
              color: AppColors.grey.withValues(alpha: 0.1),
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
          borderRadius: .circular(18),
          border: .all(color: AppColors.white),
        ),
        child: const Center(
          child: Text(
            "No photos added",
            style: TextStyle(color: AppColors.grey),
          ),
        ),
      );
    }

    // Add "Add" button if less than 6 total
    if (state.images.length + state.existingImageUrls.length < 6) {
      widgets.add(AddPhotoButton(onTap: () => context.pop()));
    }

    return SizedBox(
      height: 105.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widgets.length,
        separatorBuilder: (_, _) => horizontalSpace(10.w),
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
}
