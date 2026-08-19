import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/features/create_listing/manager/cubit/listing_cubit.dart';
import 'package:rentora/features/create_listing/presentation/screens/item_details_screen.dart';
import 'package:rentora/features/create_listing/presentation/widgets/category_card.dart';
import 'package:rentora/features/create_listing/presentation/widgets/category_model.dart';
import 'package:rentora/features/create_listing/presentation/widgets/header_button.dart';

class ChooseCategoryScreen extends StatefulWidget {
  const ChooseCategoryScreen({super.key});

  @override
  State<ChooseCategoryScreen> createState() => _ChooseCategoryScreenState();
}

class _ChooseCategoryScreenState extends State<ChooseCategoryScreen> {
  int? selectedIndex;

  final List<CategoryModel> categories = [
    CategoryModel(
      title: 'Cameras',
      id: 'Cameras',
      subtitle: 'DSLR, Mirrorless, Lenses...',
      icon: Icons.camera_alt_outlined,
      color: AppColors.primaryColor,
    ),
    CategoryModel(
      title: 'Electronics',
      id: 'Electronics',
      subtitle: 'Laptops, Tablets, Phones...',
      icon: Icons.laptop_mac_outlined,
      color: AppColors.success,
    ),
    CategoryModel(
      title: 'Gaming',
      id: 'Gaming',
      subtitle: 'PS5, Xbox, VR, Accessories...',
      icon: Icons.sports_esports_outlined,
      color: AppColors.warning,
    ),
    CategoryModel(
      title: 'Sports & Fitness',
      id: 'Sports & Fitness',
      subtitle: 'Equipment, Bikes, Accessories...',
      icon: Icons.fitness_center_outlined,
      color: AppColors.success,
    ),
    CategoryModel(
      title: 'Tools & DIY',
      id: 'Tools & DIY',
      subtitle: 'Drills, Tools, Machinery...',
      icon: Icons.handyman_outlined,
      color: AppColors.primaryColor,
    ),
    CategoryModel(
      title: 'Music',
      id: 'Music',
      subtitle: 'Instruments, Audio, Accessories...',
      icon: Icons.music_note_outlined,
      color: AppColors.warning,
    ),
    CategoryModel(
      title: 'Home & Living',
      id: 'Home & Living',
      subtitle: 'Furniture, Appliances, Decor...',
      icon: Icons.chair_outlined,
      color: AppColors.primaryColor,
    ),
    CategoryModel(
      title: 'Outdoor & Travel',
      id: 'Outdoor & Travel',
      subtitle: 'Camping, Hiking, Travel gear...',
      icon: Icons.backpack_outlined,
      color: AppColors.success,
    ),
    CategoryModel(
      title: 'Vehicles',
      id: 'Vehicles',
      subtitle: 'Scooters, Cars, Bikes...',
      icon: Icons.directions_car_outlined,
      color: AppColors.warning,
    ),
    CategoryModel(
      title: 'Fashion',
      id: 'Fashion',
      subtitle: 'Clothing, Shoes, Accessories...',
      icon: Icons.shopping_bag_outlined,
      color: AppColors.primaryColor,
    ),
    CategoryModel(
      title: 'Events & Party',
      id: 'Events & Party',
      subtitle: 'Party, Wedding, Event gear...',
      icon: Icons.celebration_outlined,
      color: AppColors.success,
    ),
    CategoryModel(
      title: 'Other',
      id: 'Other',
      subtitle: 'Something else special',
      icon: Icons.more_horiz,
      color: Colors.grey,
    ),
  ];

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
  message: 'Please select a category first.',
);
    
    return;
  }

  final listingCubit = context.read<ListingCubit>();

  listingCubit.updateCategory(
    categories[selectedIndex!].id,
  );

 Navigator.pushNamed(
  context,
  Routes.itemDetailsScreen,
  arguments: context.read<ListingCubit>(),
);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header (unchanged)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  HeaderButton(
                    icon: Icons.arrow_back,
                    onTap: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Choose a category',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF171717),
                        ),
                      ),
                    ),
                  ),
                  HeaderButton(
                    icon: Icons.close,
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            // Progress bar (unchanged)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 160.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7E9EA),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 70,
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
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
                              const SizedBox(height: 10),
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
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: 0.92,
                      ),
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return CategoryCard(
                          category: category,
                          isSelected: selectedIndex == index,
                          onTap: () => selectCategory(index),
                        );
                      },
                    ),
                    // const SizedBox(height: 20),
                   verticalSpace(20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(.07),
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
                        horizontalSpace( 8),
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
              child: SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      horizontalSpace(10),
                      Icon(Icons.arrow_forward_rounded),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}