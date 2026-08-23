import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/setup_profile/data/models/category_model.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(10),
        //
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Text(
            l10n.categories,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
        ),
        //
        verticalSpace(12),
        //
        SizedBox(
          height: 95.h,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (context, index) => horizontalSpace(20),
            itemBuilder: (context, index) {
              final category = categories[index];
              final iconPath = _getCategoryIcon(category);
              final categoryModel = CategoryModel(
                id: category,
                name: category,
                iconPath: iconPath,
              );

              return GestureDetector(
                onTap: () => context.pushNamed(
                  Routes.categoryDetailsScreen,
                  arguments: category,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //
                    Container(
                      width: 60.w,
                      height: 60.w,
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.grey.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          iconPath,
                          width: 22.w,
                          height: 22.h,
                          colorFilter: const ColorFilter.mode(
                            AppColors.secondaryColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    //
                    verticalSpace(8),
                    //
                    Text(
                      categoryModel.getLocalizedName(l10n),
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
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
