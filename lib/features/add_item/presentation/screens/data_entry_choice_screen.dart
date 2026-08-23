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
import 'package:rentora/features/add_item/presentation/components/add_item_choice_card.dart';
import 'package:rentora/features/add_item/presentation/components/add_item_progress_bar.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

class DataEntryChoiceScreen extends StatelessWidget {
  const DataEntryChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == .dark;
    return BlocBuilder<AddItemCubit, AddItemState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                CustomAppBar(text: l10n.addNewListing),
                // Progress Bar (Step 2)
                AddItemProgressBar(
                  title: l10n.detailsMethod,
                  stepNumber: l10n.stepOf("2", "7"),
                ),
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: .fromLTRB(20.w, 30.h, 20.w, 20.h),
                    child: Column(
                      crossAxisAlignment: .center,
                      children: [
                        // Photo Thumbnail
                        if (state.mainPhoto != null)
                          Container(
                            width: 140.w,
                            height: 140.w,
                            decoration: BoxDecoration(
                              borderRadius: .circular(24),
                              border: .all(
                                color: AppColors.primaryColor.withValues(
                                  alpha: 0.2,
                                ),
                                width: 3,
                              ),
                              image: DecorationImage(
                                image: FileImage(File(state.mainPhoto!.path)),
                                fit: .cover,
                              ),
                            ),
                          ),

                        verticalSpace(30),
                        Text(
                          l10n.howAddDetails,
                          textAlign: .center,
                          style: TextStyle(
                            fontSize: 27.sp,
                            height: 1.2.h,
                            fontWeight: .w800,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.black,
                          ),
                        ),
                        verticalSpace(12),
                        Text(
                          l10n.detailsMethodDesc,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.sp,
                            height: 1.45.h,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.grey,
                          ),
                        ),
                        verticalSpace(40),
                        // Action Buttons
                        AddItemChoiceCard(
                          isDark: isDark,
                          icon: Icons.edit_note_rounded,
                          title: l10n.fillManually,
                          subtitle: l10n.enterDetails,
                          onTap: () => context.pushNamed(
                            Routes.categoryScreen,
                            arguments: context.read<AddItemCubit>(),
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
      },
    );
  }
}
