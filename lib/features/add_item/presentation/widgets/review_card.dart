import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
    this.onEdit,
  });
  final String title;
  final IconData icon;
  final Widget child;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightGrey,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? AppColors.darkShadow
                : Colors.black.withOpacity(.025),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 38.sp,
                height: 38.sp,
                decoration: BoxDecoration(
                  color:
                      (isDark
                              ? AppColors.secondaryColor
                              : AppColors.primaryColor)
                          .withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  icon,
                  color: isDark
                      ? AppColors.secondaryColor
                      : AppColors.primaryColor,
                  size: 20.sp,
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: .w800,
                    color: isDark ? AppColors.darkTextPrimary : AppColors.black,
                  ),
                ),
              ),

              if (onEdit != null)
                GestureDetector(
                  onTap: onEdit,
                  child: Padding(
                    padding: .all(6.sp),
                    child: Icon(
                      Icons.edit_outlined,
                      size: 20,
                      color: isDark
                          ? AppColors.secondaryColor
                          : AppColors.primaryColor,
                    ),
                  ),
                ),
            ],
          ),

          verticalSpace(7),

          child,
        ],
      ),
    );
  }
}
