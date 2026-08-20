import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';

class HomeCategories extends StatelessWidget {
  final List<String> categories;

  const HomeCategories({super.key, required this.categories});

  ///
  String _getCategoryIcon(String categoryName) {
    final name = categoryName.toLowerCase();
    if (name.contains('camera')) return 'assets/svgs/categories/camera.svg';
    if (name.contains('electronic')) {
      return 'assets/svgs/categories/electronics.svg';
    }
    if (name.contains('gam')) return 'assets/svgs/categories/gaming.svg';
    if (name.contains('sport')) return 'assets/svgs/categories/sports.svg';
    if (name.contains('tool')) return 'assets/svgs/categories/tools.svg';
    if (name.contains('camp')) return 'assets/svgs/categories/camping.svg';
    if (name.contains('equip')) return 'assets/svgs/categories/equipment.svg';
    if (name.contains('book')) return 'assets/svgs/categories/books.svg';

    return 'assets/svgs/categories/electronics.svg';
  }

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: .start,
      children: [
        verticalSpace(10),
        //
        Padding(
          padding: .symmetric(horizontal: 18.w),
          child: Text(
            "Categories",
            style: TextStyle(fontSize: 18.sp, fontWeight: .bold),
          ),
        ),
        //
        verticalSpace(12),
        //
        SizedBox(
          height: 95.h,
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: .symmetric(horizontal: 18.w),
            scrollDirection: .horizontal,
            itemCount: categories.length,
            separatorBuilder: (context, index) => horizontalSpace(20),
            itemBuilder: (context, index) {
              final category = categories[index];
              final iconPath = _getCategoryIcon(category);

              return GestureDetector(
                onTap: () => context.pushNamed(
                  Routes.categoryDetailsScreen,
                  arguments: category,
                ),
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    //
                    Container(
                      width: 60.w,
                      height: 60.w,
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        shape: .circle,
                        border: .all(
                          color: AppColors.grey.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          iconPath,
                          width: 22.w,
                          height: 22.h,
                          colorFilter: const .mode(
                            AppColors.secondaryColor,
                            .srcIn,
                          ),
                        ),
                      ),
                    ),
                    //
                    verticalSpace(8),
                    //
                    Text(
                      category.capitalizeFirst(),
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: .w500,
                        color: AppColors.black.withValues(alpha: 0.7),
                      ),
                    ),
                    //
                  ],
                ),
              );
            },
          ),
        ),
        //
        verticalSpace(24),
        //
      ],
    );
  }
}
