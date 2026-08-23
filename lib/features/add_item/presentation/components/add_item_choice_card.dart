import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class AddItemChoiceCard extends StatelessWidget {
  const AddItemChoiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.isDark,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: 1.0,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withValues(
              alpha: isDark ? 0.2 : 0.05,
            ),
            borderRadius: .circular(20),
            border: .all(
              color: (isDark
                  ? AppColors.secondaryColor
                  : AppColors.primaryColor),

              width: 2,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 54.w,
                height: 54.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: .circular(16),
                ),
                child: Icon(icon, color: AppColors.white, size: 28.sp),
              ),
              horizontalSpace(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: .w800,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(6),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: isDark
                    ? AppColors.secondaryColor
                    : AppColors.primaryColor,
                size: 28.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
