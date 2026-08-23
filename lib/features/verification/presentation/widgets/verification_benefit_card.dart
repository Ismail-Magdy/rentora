import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class VerificationBenefitCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const VerificationBenefitCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightGrey,
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? AppColors.darkShadow
                : AppColors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.primaryColor.withValues(alpha: 0.2)
                  : AppColors.infoLight,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: isDark ? AppColors.secondaryColor : AppColors.primaryColor,
              size: 20.sp,
            ),
          ),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.darkTextPrimary : AppColors.black,
                  ),
                ),
                verticalSpace(2),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.darkGrey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
