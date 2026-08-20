import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/add_item/manager/add_item_cubit.dart';
import 'package:rentora/features/add_item/manager/add_item_state.dart';
import 'package:rentora/features/add_item/presentation/widgets/header_button.dart';

class DataEntryChoiceScreen extends StatelessWidget {
  const DataEntryChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddItemCubit, AddItemState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
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
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ),
                      HeaderButton(
                        icon: Icons.close_rounded,
                        onTap: () => Navigator.popUntil(
                          context,
                          (route) => route.isFirst,
                        ),
                      ),
                    ],
                  ),
                ),

                // Progress Bar (Step 2)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Details Method',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.grey.withValues(alpha: 0.7),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Step 2 of 6',
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
                              flex: 2,
                              child: Container(
                                height: 6.h,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                height: 6.h,
                                color: AppColors.grey.withValues(alpha: 0.3),
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
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Photo Thumbnail
                        if (state.mainPhoto != null)
                          Container(
                            width: 140.w,
                            height: 140.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: AppColors.primaryColor.withValues(
                                  alpha: 0.2,
                                ),
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.black.withValues(alpha: 0.1),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                              image: DecorationImage(
                                image: FileImage(File(state.mainPhoto!.path)),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                        verticalSpace(30),
                        Text(
                          'How would you like to add details?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 27.sp,
                            height: 1.2.h,
                            fontWeight: FontWeight.w800,
                            color: AppColors.black,
                          ),
                        ),
                        verticalSpace(12),
                        Text(
                          'You can fill in the details manually or let our AI suggest them based on your photo.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.sp,
                            height: 1.45.h,
                            color: AppColors.grey,
                          ),
                        ),
                        verticalSpace(40),

                        // Action Buttons
                        _buildChoiceCard(
                          context,
                          icon: Icons.edit_note_rounded,
                          title: 'Fill Manually',
                          subtitle: 'Enter all details yourself',
                          onTap: () {
                            context.pushNamed(
                              Routes.categoryScreen,
                              arguments: context.read<AddItemCubit>(),
                            );
                          },
                          isPrimary: true,
                        ),
                        verticalSpace(16),
                        _buildChoiceCard(
                          context,
                          icon: Icons.auto_awesome_rounded,
                          title: 'Auto-fill with AI',
                          subtitle: 'Let AI suggest details from photo',
                          onTap: null, // Disabled
                          badge: 'Coming Soon',
                          isPrimary: false,
                        ),
                      ],
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

  Widget _buildChoiceCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback? onTap,
    bool isPrimary = false,
    String? badge,
  }) {
    final bool isEnabled = onTap != null;

    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.6,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: isPrimary
                ? AppColors.primaryColor.withValues(alpha: 0.05)
                : AppColors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isPrimary
                  ? AppColors.primaryColor.withValues(alpha: 0.5)
                  : AppColors.grey.withValues(alpha: 0.2),
              width: isPrimary ? 2 : 1,
            ),
            boxShadow: isEnabled
                ? [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 54.w,
                height: 54.w,
                decoration: BoxDecoration(
                  color: isPrimary
                      ? AppColors.primaryColor
                      : AppColors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  color: isPrimary ? AppColors.white : AppColors.darkGrey,
                  size: 28.sp,
                ),
              ),
              horizontalSpace(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.black,
                          ),
                        ),
                        if (badge != null) ...[
                          horizontalSpace(8),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.warning.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              badge,
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.warning,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    verticalSpace(6),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 13.sp, color: AppColors.grey),
                    ),
                  ],
                ),
              ),
              if (isEnabled)
                Icon(
                  Icons.chevron_right_rounded,
                  color: isPrimary ? AppColors.primaryColor : AppColors.grey,
                  size: 28.sp,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
