import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';
import 'package:rentora/features/add_item/manager/add_item_cubit.dart';
import 'package:rentora/features/add_item/manager/add_item_state.dart';
import 'package:rentora/features/add_item/presentation/components/add_item_progress_bar.dart';

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
                CustomAppBar(text: "Add New Listing"),

                // Progress Bar (Step 2)
                AddItemProgressBar(
                  title: "Details Method",
                  stepNumber: "Step 2 of 7",
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
                          title: 'Auto fill with AI',
                          subtitle: 'Let AI suggest details from photo',
                          onTap: null, // Disabled
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
