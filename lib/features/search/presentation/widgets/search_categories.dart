import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/setup_profile/data/models/category_model.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

class SearchCategories extends StatelessWidget {
  final List<String> categories;
  final String? selectedCategory;
  final ValueChanged<String?> onCategorySelected;

  const SearchCategories({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: [
        _CategoryChip(
          label: l10n.all,
          isSelected: selectedCategory == null,
          onTap: () => onCategorySelected(null),
        ),
        ...categories.map(
          (category) => _CategoryChip(
            label: CategoryModel(
              id: category,
              name: category,
              iconPath: '',
            ).getLocalizedName(l10n),
            isSelected: category == selectedCategory,
            onTap: () => onCategorySelected(category),
          ),
        ),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? AppColors.secondaryColor : AppColors.primaryColor)
              : (isDark ? AppColors.darkSurface : AppColors.white),
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(
            color: isSelected
                ? (isDark ? AppColors.secondaryColor : AppColors.primaryColor)
                : (isDark ? AppColors.darkBorder : AppColors.lightGrey),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primaryColor.withValues(alpha: 0.15),
                    blurRadius: 8.r,
                    offset: Offset(0, 3.h),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: isSelected
                ? AppColors.white
                : (isDark ? AppColors.darkTextSecondary : AppColors.darkGrey),
          ),
        ),
      ),
    );
  }
}
