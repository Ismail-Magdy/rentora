import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';
import 'package:rentora/core/widgets/custom_button.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/features/add_item/manager/add_item_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentora/features/setup_profile/data/models/category_model.dart';
import 'package:rentora/features/add_item/presentation/components/add_item_progress_bar.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

class ChooseCategoryScreen extends StatefulWidget {
  const ChooseCategoryScreen({super.key});

  @override
  State<ChooseCategoryScreen> createState() => _ChooseCategoryScreenState();
}

class _ChooseCategoryScreenState extends State<ChooseCategoryScreen> {
  int? selectedIndex;

  List<CategoryModel> get categories {
    return [
      ...CategoryModel.categories,
      CategoryModel(id: "other", name: "Other", iconPath: ""),
    ];
  }

  void selectCategory(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void onNext() {
    final l10n = AppLocalizations.of(context)!;
    if (selectedIndex == null) {
      showFeedbackDialog(
        context,
        icon: Icons.category_outlined,
        color: AppColors.warning,
        title: l10n.categoryRequired,
        message: l10n.selectCategoryFirst,
      );

      return;
    }

    final listingCubit = context.read<AddItemCubit>();

    listingCubit.updateCategory(categories[selectedIndex!].id);

    Navigator.pushNamed(
      context,
      Routes.addItemDetailsScreen,
      arguments: listingCubit,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(text: l10n.chooseCategory),
            // Progress Bar (Step 3)
            AddItemProgressBar(
              title: l10n.category,
              stepNumber: l10n.stepOf("3", "7"),
            ),
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: .fromLTRB(20.w, 28.h, 20.w, 20.h),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Row(
                      crossAxisAlignment: .center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                l10n.selectCategoryMatch,
                                style: TextStyle(
                                  fontSize: 27.sp,
                                  height: 1.2,
                                  fontWeight: .w800,
                                  color: isDark
                                      ? AppColors.darkTextPrimary
                                      : AppColors.black,
                                ),
                              ),
                              verticalSpace(10),
                              Text(
                                l10n.categoryHelpMatch,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  height: 1.4,
                                  color: isDark
                                      ? AppColors.darkTextSecondary
                                      : AppColors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    verticalSpace(25),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: categories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1.2,
                          ),
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final isSelected = selectedIndex == index;

                        return GestureDetector(
                          onTap: () => selectCategory(index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? (isDark
                                        ? AppColors.secondaryColor.withValues(
                                            alpha: 0.2,
                                          )
                                        : AppColors.primaryColor.withValues(
                                            alpha: 0.1,
                                          ))
                                  : (isDark
                                        ? AppColors.darkSurface
                                        : const Color(0xFFF7F7F9)),
                              borderRadius: .circular(20.r),
                              border: Border.all(
                                color: isSelected
                                    ? (isDark
                                          ? AppColors.secondaryColor
                                          : AppColors.primaryColor)
                                    : (isDark
                                          ? AppColors.darkBorder
                                          : Colors.transparent),
                                width: 2,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: .center,
                              children: [
                                category.id == 'other'
                                    ? Icon(
                                        Icons.more_horiz,
                                        size: 35.sp,
                                        color: isSelected
                                            ? (isDark
                                                  ? AppColors.secondaryColor
                                                  : AppColors.primaryColor)
                                            : AppColors.secondaryColor,
                                      )
                                    : SvgPicture.asset(
                                        category.iconPath,
                                        width: 35.sp,
                                        height: 35.sp,
                                        colorFilter: .mode(
                                          isSelected
                                              ? (isDark
                                                    ? AppColors.secondaryColor
                                                    : AppColors.primaryColor)
                                              : AppColors.secondaryColor,
                                          .srcIn,
                                        ),
                                      ),
                                verticalSpace(10),
                                Text(
                                  category.getLocalizedName(l10n),
                                  textAlign: .center,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? (isDark
                                              ? AppColors.secondaryColor
                                              : AppColors.primaryColor)
                                        : (isDark
                                              ? AppColors.darkTextPrimary
                                              : Colors.black87),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Next button
            Padding(
              padding: .fromLTRB(20.w, 8.h, 20.w, 20.h),
              child: CustomButton(text: l10n.next, onPressed: onNext),
            ),
          ],
        ),
      ),
    );
  }
}
// 240