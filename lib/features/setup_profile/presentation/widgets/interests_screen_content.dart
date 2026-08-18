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
                          onTap: () =>
                              context.pushReplacementNamed(Routes.rootScreen),
                          child: Text(
                            "Skip",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                        //
                        Text(
                          "Rentora",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: .bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        //
                      ],
                    ),
                    //
                    verticalSpace(32),
                    //
                    Text(
                      "What are your interests?",
                      style: TextStyle(fontSize: 25.sp, fontWeight: .bold),
                    ),
                    //
                    verticalSpace(12),
                    //
                    Text(
                      "Choose the categories you're interested in so we can personalize your experience and show you the most relevant items.",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.darkGrey,
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
                            ? AppColors.primaryColor.withValues(alpha: 0.1)
                            : const Color(0xFFF7F7F9),
                        borderRadius: .circular(20.r),
                        border: .all(
                          color: isSelected
                              ? AppColors.primaryColor
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
                                  ? AppColors.primaryColor
                                  : AppColors.secondaryColor,
                              .srcIn,
                            ),
                          ),
                          //
                          verticalSpace(10),
                          //
                          Text(
                            category.name,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: isSelected ? .bold : .w500,
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : Colors.black87,
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
          text: "Continue",
          isLoading: state is InterestsSaving,
          onPressed: () => cubit.saveInterests(),
        ),

        verticalSpace(10),
      ],
    );
  }
}
