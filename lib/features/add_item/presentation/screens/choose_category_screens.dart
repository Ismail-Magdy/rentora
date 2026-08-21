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
    if (selectedIndex == null) {
      showFeedbackDialog(
        context,
        icon: Icons.category_outlined,
        color: AppColors.warning,
        title: 'Category Required',
        message: 'Please select a category first',
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
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(text: "Choose a category"),
            // Progress Bar (Step 3)
            AddItemProgressBar(title: "Category", stepNumber: "Step 3 of 7"),
            // Content (unchanged)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Select the category that\nbest matches your item',
                                style: TextStyle(
                                  fontSize: 27,
                                  height: 1.2,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.black,
                                ),
                              ),
                              verticalSpace(10),
                              const Text(
                                'This helps us show your item to the right people.',
                                style: TextStyle(
                                  fontSize: 15,
                                  height: 1.4,
                                  color: AppColors.grey,
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
                                  ? AppColors.primaryColor.withValues(
                                      alpha: 0.1,
                                    )
                                  : const Color(0xFFF7F7F9),
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primaryColor
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                category.id == 'other'
                                    ? Icon(
                                        Icons.more_horiz,
                                        size: 35.sp,
                                        color: isSelected
                                            ? AppColors.primaryColor
                                            : AppColors.secondaryColor,
                                      )
                                    : SvgPicture.asset(
                                        category.iconPath,
                                        width: 35.sp,
                                        height: 35.sp,
                                        colorFilter: ColorFilter.mode(
                                          isSelected
                                              ? AppColors.primaryColor
                                              : AppColors.secondaryColor,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                verticalSpace(10),
                                Text(
                                  category.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? AppColors.primaryColor
                                        : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    verticalSpace(20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.07),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.verified_outlined,
                            color: AppColors.success,
                            size: 20,
                          ),
                          horizontalSpace(8),
                          const Text(
                            'You can only choose one category.',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Next button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: CustomButton(text: "Next", onPressed: onNext),
            ),
          ],
        ),
      ),
    );
  }
}
