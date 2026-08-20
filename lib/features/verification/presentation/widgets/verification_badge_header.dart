import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/themes/app_colors.dart';

class VerificationBadgeHeader extends StatelessWidget {
  const VerificationBadgeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: .bottomRight,
        children: [
          Container(
            width: 100.w,
            height: 100.w,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.12),
              shape: .circle,
            ),
            child: Icon(
              Icons.verified_user,
              color: AppColors.primaryColor,
              size: 52.sp,
            ),
          ),
          Positioned(
            bottom: 4.h,
            right: 4.w,
            child: Container(
              padding: .all(4.r),
              decoration: const BoxDecoration(
                color: AppColors.white,
                shape: .circle,
              ),
              child: Container(
                padding: .all(4.r),
                decoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: .circle,
                ),
                child: Icon(Icons.check, color: AppColors.white, size: 14.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
