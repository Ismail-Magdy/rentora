import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

class ItemFeaturesSection extends StatelessWidget {
  final List<String> features;

  const ItemFeaturesSection({super.key, required this.features});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: .start,
      children: [
        //
        Text(
          l10n.keyFeatures,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: .bold,
            color: isDark ? AppColors.darkTextPrimary : AppColors.black,
          ),
        ),
        //
        verticalSpace(12),
        //
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: features.map((feature) {
            return Container(
              padding: .symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isDark
                      ? AppColors.darkBorder
                      : AppColors.grey.withValues(alpha: 0.4),
                ),
                borderRadius: .circular(8.r),
              ),
              child: Row(
                mainAxisSize: .min,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: isDark ? AppColors.secondaryColor : AppColors.primaryColor,
                    size: 16.sp,
                  ),
                  horizontalSpace(8),
                  Text(
                    feature,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isDark ? AppColors.darkTextPrimary : AppColors.black,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        //
      ],
    );
  }
}
