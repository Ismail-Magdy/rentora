import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_button.dart';

class BookingActionBar extends StatelessWidget {
  final String label;
  final String totalText;
  final String buttonText;
  final VoidCallback onPressed;
  final double? buttonWidth;

  const BookingActionBar({
    super.key,
    required this.label,
    required this.totalText,
    required this.buttonText,
    required this.onPressed,
    this.buttonWidth = 170,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? AppColors.darkShadow
                : AppColors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: isDark ? AppColors.darkTextSecondary : AppColors.grey,
                    fontSize: 12.sp,
                  ),
                ),
                verticalSpace(8),
                Text(
                  totalText,
                  style: TextStyle(
                    color: isDark ? AppColors.darkTextPrimary : AppColors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            CustomButton(
              text: buttonText,
              width: buttonWidth,
              height: 52.h,
              borderRadius: 12,
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
