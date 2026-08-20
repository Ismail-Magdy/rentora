import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_button.dart';

class PendingStatusCard extends StatelessWidget {
  final VoidCallback onBackToHome;

  const PendingStatusCard({super.key, required this.onBackToHome});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.dividerColor, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Hourglass circular icon
          Container(
            width: 88.w,
            height: 88.w,
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.hourglass_bottom_rounded,
                color: AppColors.warning,
                size: 46.sp,
              ),
            ),
          ),
          verticalSpace(16),

          // Under Review Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.amberLight,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: AppColors.amber.withValues(alpha: 0.3),
                width: 1.w,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: const BoxDecoration(
                    color: AppColors.amber,
                    shape: BoxShape.circle,
                  ),
                ),
                horizontalSpace(8),
                Text(
                  "Under Review",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.amberDark,
                  ),
                ),
              ],
            ),
          ),
          verticalSpace(18),

          // Title
          Text(
            "Documents Received",
            textAlign: .center,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: .bold,
              color: AppColors.black,
            ),
          ),
          verticalSpace(10),

          // Subtitle message
          Text(
            "We're reviewing your information. This usually takes less than 24 hours. We'll notify you once your identity has been verified",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.darkGrey,
              height: 1.5,
              fontWeight: .w400,
            ),
          ),
          verticalSpace(24),

          // Back to Home Button WITH Icon
          CustomButton(
            text: "Back to Home",
            icon: Icons.home_rounded,
            onPressed: onBackToHome,
            color: AppColors.primaryColor,
            borderRadius: 16.r,
            height: 52.h,
            fontSize: 16.sp,
          ),
        ],
      ),
    );
  }
}
