import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_button.dart';
import 'package:rentora/features/setup_profile/data/models/category_model.dart';
import 'package:rentora/features/setup_profile/manager/interests/interests_cubit.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

class InterestsScreenContent extends StatelessWidget {
  const InterestsScreenContent({
    super.key,
    required this.cubit,
    required this.state,
  });
  final InterestsCubit cubit;
  final InterestsState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        //
        Expanded(
          child: CustomScrollView(
            slivers: [
              // Header section (Skip, Logo, Titles)
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    //
                    verticalSpace(10),
                    //
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        //
                        GestureDetector(
                          onTap: () => context.pushNamedAndRemoveUntil(
                            Routes.rootScreen,
                            predicate: (route) => false,
                          ),
                          child: Text(
                            l10n.skip,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: isDark ? AppColors.darkTextSecondary : AppColors.grey,
                            ),
                          ),
                        ),
                        //
                        Text(
                          l10n.rentora,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: .bold,
                            color: isDark ? AppColors.secondaryColor : AppColors.primaryColor,
                          ),
                        ),
                        //
                        ],
                    ),
                    //
                    verticalSpace(32),
                    //
                    Text(
                      l10n.interestsQuestion,
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: .bold,
                        color: isDark ? AppColors.darkTextPrimary : AppColors.black,
                      ),
                    ),
                    //
                    verticalSpace(12),
                    //
                    Text(
                      l10n.interestsDescription,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.darkGrey,
                        height: 1.5,
                      ),
                    ),
                    //
                    verticalSpace(32),
                    //
                  ],
                ),
              ),
              //
              // The Grid (Categories)
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 1.2,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  final category = CategoryModel.categories[index];
                  final isSelected = cubit.selectedInterests.contains(
                    category.id,
                  );

                  return GestureDetector(
                    onTap: () => cubit.toggleInterest(category.id),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryColor.withValues(alpha: 0.15)
                            : (isDark ? AppColors.darkContainer : const Color(0xFFF7F7F9)),
                        borderRadius: .circular(20.r),
                        border: .all(
                          color: isSelected
                              ? (isDark ? AppColors.secondaryColor : AppColors.primaryColor)
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: .center,
                        children: [
                          //
                          SvgPicture.asset(
                            category.iconPath,
                            width: 35.w,
                            height: 35.h,
                            colorFilter: .mode(
                              isSelected
                                  ? (isDark ? AppColors.secondaryColor : AppColors.primaryColor)
                                  : AppColors.secondaryColor,
                              .srcIn,
                            ),
                          ),
                          //
                          verticalSpace(10),
                          //
                          Text(
                            category.getLocalizedName(l10n),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: isSelected ? .bold : .w500,
                              color: isSelected
                                  ? (isDark ? AppColors.secondaryColor : AppColors.primaryColor)
                                  : (isDark ? AppColors.darkTextPrimary : Colors.black87),
                            ),
                          ),
                          //
                        ],
                      ),
                    ),
                  );
                }, childCount: CategoryModel.categories.length),
              ),
              //
              SliverToBoxAdapter(child: verticalSpace(32)),
              //
            ],
          ),
        ),

        CustomButton(
          text: l10n.continueButton,
          isLoading: state is InterestsSaving,
          onPressed: () => cubit.saveInterests(),
        ),

        verticalSpace(10),
      ],
    );
  }
}
