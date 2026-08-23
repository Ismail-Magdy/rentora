import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class VerificationRequirementItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const VerificationRequirementItem({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkContainer : AppColors.lightGrey,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            icon,
            color: isDark ? AppColors.darkTextSecondary : AppColors.darkGrey,
            size: 18.sp,
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
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
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
    );
  }
}
